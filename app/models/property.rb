class Property < ApplicationRecord
  has_many :teams
  validates :price, :info_output, presence: true


end
