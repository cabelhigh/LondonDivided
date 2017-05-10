class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :phone_num
      t.references :property, foreign_key: true
      t.integer :money
      t.integer :blue_info
      t.integer :red_info
      t.integer :green_info
      t.integer :orange_info

      t.timestamps
    end
  end
end
