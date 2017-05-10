class RecievedQuest < ApplicationRecord
  belongs_to :team
  belongs_to :quest
end
