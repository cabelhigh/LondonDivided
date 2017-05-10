class CreateContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :contracts do |t|
      t.integer :money_output, default: 0
      t.integer :info_output, array: true, default: []
      t.integer :item_output, array: true, default: []
      t.string :name
      t.time :upkeep

      t.timestamps
    end
  end
end
