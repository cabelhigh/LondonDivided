class Property < ApplicationRecord
  has_many :teams
  validates :price, :money_output, :info_output, :district, presence: true


  private


end
