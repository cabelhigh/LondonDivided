class RemovePropertyIdFromTeams < ActiveRecord::Migration[5.0]
  def change
    remove_column :teams, :property_id
  end
end
