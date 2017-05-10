class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.integer :price
      t.integer :money_output
      t.integer :info_output
      t.integer :district

      t.timestamps
    end
  end
end
