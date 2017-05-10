class AddTimeColumnsToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :next_upkeep_hour, :datetime
    add_column :teams, :last_contacted, :datetime
  end
end
