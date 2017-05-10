class CreateRecievedQuests < ActiveRecord::Migration[5.0]
  def change
    create_table :recieved_quests do |t|
      t.references :team, foreign_key: true
      t.references :quest, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
