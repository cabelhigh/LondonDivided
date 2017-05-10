class AddClueRefsToClues < ActiveRecord::Migration[5.0]
  def change
    add_column :clues, :clue_references, :integer, array: true, default: []
  end
end
