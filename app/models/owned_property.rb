class OwnedProperty < ApplicationRecord
  belongs_to :team
  belongs_to :property
end
