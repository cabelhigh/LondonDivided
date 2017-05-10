class ChangeTimeToDateTimeInContracts < ActiveRecord::Migration[5.0]
  def change
    remove_column :contracts, :upkeep
    add_column :contracts, :upkeep, :datetime
  end
end
