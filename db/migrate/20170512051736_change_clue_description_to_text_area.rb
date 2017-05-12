class ChangeClueDescriptionToTextArea < ActiveRecord::Migration[5.0]
  def change
    change_column :clues, :description, :text
  end
end
