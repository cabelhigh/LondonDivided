class ChangeUpkeepToIntegerInContracts < ActiveRecord::Migration[5.0]
  def change
    remove_column :contracts, :upkeep
    add_column :contracts, :upkeep, :integer
  end
end
