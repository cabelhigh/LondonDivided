class CreateRecievedClues < ActiveRecord::Migration[5.0]
  def change
    create_table :recieved_clues do |t|
      t.references :team, foreign_key: true
      t.references :clue, foreign_key: true

      t.timestamps
    end
  end
end
