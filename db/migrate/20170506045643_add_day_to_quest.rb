class AddDayToQuest < ActiveRecord::Migration[5.0]
  def change
    add_column :quests, :day, :integer
  end
end
