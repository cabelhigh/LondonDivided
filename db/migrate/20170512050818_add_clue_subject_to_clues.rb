class AddClueSubjectToClues < ActiveRecord::Migration[5.0]
  def change
    add_column :clues, :clue_subject, :string
  end
end
