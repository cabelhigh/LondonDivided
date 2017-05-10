class AddFactionAndCarrierToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :faction, :integer
    add_column :teams, :carrier, :string
  end
end
