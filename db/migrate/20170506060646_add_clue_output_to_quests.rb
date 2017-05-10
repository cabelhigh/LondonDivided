class AddClueOutputToQuests < ActiveRecord::Migration[5.0]
  def change
    add_column :quests, :clue_output, :integer
  end
end
