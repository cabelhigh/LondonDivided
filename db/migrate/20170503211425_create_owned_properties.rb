class CreateOwnedProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :owned_properties do |t|
      t.references :team, foreign_key: true
      t.references :property, foreign_key: true

      t.timestamps
    end
  end
end
