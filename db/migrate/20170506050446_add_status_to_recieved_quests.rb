class AddStatusToRecievedQuests < ActiveRecord::Migration[5.0]
  def change
    add_column :recieved_quests, :status, :integer
  end
end
