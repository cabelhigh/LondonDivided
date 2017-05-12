class Quest < ApplicationRecord
  has_many :recieved_quests
  before_create :set_defaults
  before_destroy :sever_connections
  validates :quest_name, :description, :day, :quest_type, presence: true

  def day_to_string
    case self.day
    when 1
      "The Terrible Business of Theodore Humphreys"
    when 2
      "A Trial for Ann"
    when 3
      "The Civil Institution"
    end
  end

  def format_output
    output = ""
    if self.money_output!=0
      output+="Money: #{self.money_output}£ "
    end
    if self.inf_output!=0
      output+="#{inf_type} Infomration: #{self.inf_output} " #
    end
    if self.clue_output!=0
      output+="Clue: #{Clue.find(self.clue_output).name} "
    end
    if self.item_output!=0
      output+="Item: #{Item.find(self.item_output).name} "
    end
    output
  end

  def convert_type_to_int
    case self.inf_type
    when "Public"
      0
    when "Market"
      1
    when "Seedy"
      2
    when "Royal"
      3
    end
  end


private

  def set_defaults
    self.money_output = 0 if self.money_output.nil?
    self.inf_output = 0 if self.inf_output.nil?
    self.clue_output = 0 if self.clue_output.nil?
    self.item_output = 0 if self.item_output.nil?
    debugger
    self.notes = "" if self.notes.nil?
  end

  def sever_connections
    RecievedQuest.where(quest_id: self.id).destroy_all
  end
end
