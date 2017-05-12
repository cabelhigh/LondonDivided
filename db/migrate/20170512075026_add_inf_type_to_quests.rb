class AddInfTypeToQuests < ActiveRecord::Migration[5.0]
  def change
    add_column :quests, :inf_type, :string
  end
end
