class AddLevelToQuests < ActiveRecord::Migration[5.0]
  def change
    add_column :quests, :level, :integer
  end
end
