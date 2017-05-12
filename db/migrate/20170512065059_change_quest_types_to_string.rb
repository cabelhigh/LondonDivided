class ChangeQuestTypesToString < ActiveRecord::Migration[5.0]
  def change
    change_column :quests, :quest_type, :string
  end
end
