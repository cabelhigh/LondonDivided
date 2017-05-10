class OwnedContract < ApplicationRecord
  belongs_to :team
  belongs_to :contract
end
