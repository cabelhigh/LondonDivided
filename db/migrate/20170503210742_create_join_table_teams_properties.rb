class CreateJoinTableTeamsProperties < ActiveRecord::Migration[5.0]
  def change
    create_join_table :teams, :properties, :table_name => :owned_properties
  end
end
