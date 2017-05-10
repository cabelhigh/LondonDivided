class ChangeFactionToString < ActiveRecord::Migration[5.0]
  def change
    change_column :teams, :faction, :string
  end
end
