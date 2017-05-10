class CreateCheckpoints < ActiveRecord::Migration[5.0]
  def change
    create_table :checkpoints do |t|
      t.string :name
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
