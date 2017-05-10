class AddGuideNameToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :guild_name, :string
  end
end
