class DropJoinTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :owned_propertiesw
  end
end
