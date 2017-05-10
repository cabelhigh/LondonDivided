class CreateClues < ActiveRecord::Migration[5.0]
  def change
    create_table :clues do |t|
      t.string :name
      t.string :description
      t.integer :day
      t.integer :faction
      t.integer :points

      t.timestamps
    end
  end
end
