class AddUserToDebugs < ActiveRecord::Migration[5.0]
  def change
    add_column :debugs, :user, :string
  end
end
