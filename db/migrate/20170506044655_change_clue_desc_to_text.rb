class ChangeClueDescToText < ActiveRecord::Migration[5.0]
  def change
    remove_column :clues, :description
    add_column :clues, :description, :text
  end
end
