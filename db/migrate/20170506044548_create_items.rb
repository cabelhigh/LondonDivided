class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :type
      t.integer :value

      t.timestamps
    end
  end
end
