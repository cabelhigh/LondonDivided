class CreateDebugs < ActiveRecord::Migration[5.0]
  def change
    create_table :debugs do |t|
      t.text :log

      t.timestamps
    end
  end
end
