class DropQuests < ActiveRecord::Migration[5.0]
  def change
    drop_table :recieved_quests
    drop_table :quests
  end
end
