class AddNetWorthToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :net_worth, :integer
  end
end
