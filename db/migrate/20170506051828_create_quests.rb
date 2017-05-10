class CreateQuests < ActiveRecord::Migration[5.0]
  def change
    create_table :quests do |t|
      t.string :quest_name
      t.text :description
      t.integer :day
      t.integer :quest_type
      t.integer :money_output
      t.integer :info_output
      t.integer :item_output
      t.integer :dependent_on
      t.integer :unlocks

      t.timestamps
    end
  end
end
