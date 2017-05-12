class AddInfOutputToQuests < ActiveRecord::Migration[5.0]
  def change
    add_column :quests, :inf_output, :integer
  end
end
