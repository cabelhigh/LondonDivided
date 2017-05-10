class RemoveInfoOutputFromQuests < ActiveRecord::Migration[5.0]
  def change
    remove_column :quests, :info_output
  end
end
