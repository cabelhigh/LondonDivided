class Team < ApplicationRecord
  has_many :checkpoints
  has_many :properties
  has_many :owned_properties
  has_many :recieved_quests
  has_many :recieved_clues
  has_many :owned_contracts
  before_create :set_defaults, :initial_payout, :send_welcome_message
  # before_update :payout_properties
  before_destroy :cleanup_references
  validates :phone_num, presence: true, length: {minimum: 10, maximum: 12}
  validates :guild_name, presence: true
  after_validation :format_phone_num, :convert_carrier


  def check_time
    DateTime.now > (self.next_upkeep_hour)+55.minutes && DateTime.now < (self.next_upkeep_hour)+65.minutes
  end

  def add_property prop_id
    self.owned_properties << OwnedProperty.new({property_id: prop_id})
  end

  def buy_property prop_id
    if OwnedProperty.where(property_id: prop_id).empty?
      self.owned_properties << OwnedProperty.new({property_id: prop_id})
      self.money -= Property.find(prop_id).price
    else
      -1
    end
  end

  def recieve_quest quest_id

    if self.recieved_quests.select{|rq| rq.quest_id==quest_id}.empty?
      self.recieved_quests << RecievedQuest.create({quest_id: quest_id, status: 1}) #1 means in-progress, 2 means completed
    else
      -1
    end
  end

  def get_clue clue_id

    if self.recieved_clues.select{|rc| rc.clue_id==clue_id}.empty?
      self.recieved_clues << RecievedClue.create({clue_id: clue_id})
    else
      -1
    end
  end

  def get_contract contract_id
    if self.owned_contracts.select{|oc| oc.contract_id==contract_id}.empty?
      self.owned_contracts << OwnedContract.create({contract_id: contract_id})
    else
      -1
    end

  end

  #to be called AFTER someone has physically collected the payout...or however we want to do it
  def store_payout
    self.money+= self.outstanding_payout[0]
    self.blue_info+= self.outstanding_payout[1]
    self.red_info+= self.outstanding_payout[2]
    self.green_info+= self.outstanding_payout[3]
    self.orange_info+= self.outstanding_payout[4]
    self.outstanding_payout = Array.new(5,0)
  end

  def add_to_payout(index, amount) #0 is money, 1-4 INFs
    self.outstanding_payout[index]+=amount
  end

  def pay_rent rent
    self.money-=rent
  end

  def get_rent
    self.owned_properties.sum{|i| Property.find(i.property_id).price}
  end

  def send_message(client, message)
    client.account.messages.create(from: "+16194040062", to: "+#{phone_num}", body: "#{message}")
  end

  def send_hour_message client
    client.account.messages.create(from: "+16194040062", to: "+#{phone_num}", body: "Dear valued #{faction}, you have a payout to collect back at the main booth! It is #{format_payout}.")
  end

  def send_welcome_message
    if self.phone_num[0..3]!="1111"
      account_sid = "AC9e9bfc18bbe241dbce81a0874e809d12"
      auth_token = "953bb0be1b63e1d1736e1b2030419da7"
      client = Twilio::REST::Client.new account_sid, auth_token
      client.account.messages.create(from: "+16194040062", to: "+#{phone_num}", body: "Welcome to Divided London! You will recieve periodic text updates from us about the state of the game and any outstanding resources you need to collect. Have fun and let us know if you have any questions!")
    end
  end


  private

    def format_payout
      "#{outstanding_payout[0]} pound, #{outstanding_payout[1]} blue, #{outstanding_payout[2]} red, #{outstanding_payout[3]} green, and #{outstanding_payout[4]} orange"
    end


    def format_phone_num
      self.phone_num=self.phone_num.tr('()-', '')
      self.phone_num=self.phone_num.prepend("1") if self.phone_num.length==10
    end

    def set_defaults
      self.money = 5
      self.blue_info = 0
      self.red_info = 0
      self.green_info = 0
      self.orange_info = 0
      self.next_upkeep_hour = DateTime.now.at_end_of_hour+1.second
      self.last_contacted = DateTime.now
      self.outstanding_payout = Array.new(5, 0)
      self.faction = (Team.all.count%2==0 ? "Lamplighter" : "Rosarian")
    end

    def initial_payout
      case Random.rand(4)
      when 0
        self.blue_info = 5
      when 1
        self.red_info = 5
      when 2
        self.green_info = 5
      else
        self.orange_info = 5
      end
    end

    def cleanup_references
      self.owned_properties.destroy_all
      self.recieved_quests.destroy_all
      self.owned_contracts.destroy_all
      self.recieved_clues.destroy_all
    end

    def get_district_output(prop_id, dist)
      prop = Property.find(prop_id)
      dist == prop.district ? prop.info_output : 0
    end

    def convert_carrier
      case self.carrier
      when "AT&T"
        self.carrier="@txt.att.net"
      when "Boost Mobile"
        self.carrier="@myboostmobile.com"
      when "Comcast PCS"
        self.carrier="@comcastpcs.textmsg.com"
      when "Cricket"
        self.carrier="@sms.mycricket.com"
      when "Metro PCS"
        self.carrier="@mymetropcs.com"
      when "Sprint PCS"
        self.carrier="@messaging.sprintpcs.com"
      when "T-Mobile"
        self.carrier="@tmomail.net"
      when "Virgin Mobile"
        self.carrier="@vmobl.net"
      when "Verizon Wireless"
        self.carrier="@vtext.com"
      end
    end
end
