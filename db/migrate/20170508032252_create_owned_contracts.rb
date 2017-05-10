class CreateOwnedContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :owned_contracts do |t|
      t.references :team, foreign_key: true
      t.references :contract, foreign_key: true

      t.timestamps
    end
  end
end
