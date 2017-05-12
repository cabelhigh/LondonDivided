class AddQuestGiverToClue < ActiveRecord::Migration[5.0]
  def change
    add_column :clues, :quest_giver, :string
  end
end
