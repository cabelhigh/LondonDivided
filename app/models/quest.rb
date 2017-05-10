class Quest < ApplicationRecord
  has_many :recieved_quests
  before_create :set_defaults
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

  def quest_type_to_string
    case self.quest_type
    when 0
      "Item Turnin"
    when 1
      "Intrigue"
    when 2
      "Cash"
    when 3
      "Upgrade"
    when 4
      "Madness"
    when 5
      "Terrible Business"
    when 6
      "Trial for Anna"
    when 7
      "Civil Institution"
    end
  end


private

  def set_defaults
    self.money_output = 0 if self.money_output.nil?
    self.blue_output = 0 if self.blue_output.nil?
    self.red_output = 0 if self.red_output.nil?
    self.green_output = 0 if self.green_output.nil?
    self.orange_output = 0 if self.orange_output.nil?
  end
end
