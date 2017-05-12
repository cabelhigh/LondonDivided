class RemoveFactionFromClues < ActiveRecord::Migration[5.0]
  def change
    remove_column :clues, :faction
  end
end
