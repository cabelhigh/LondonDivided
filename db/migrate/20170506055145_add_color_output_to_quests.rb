class AddColorOutputToQuests < ActiveRecord::Migration[5.0]
  def change
    add_column :quests, :red_output, :integer
    add_column :quests, :blue_output, :integer
    add_column :quests, :green_output, :integer
    add_column :quests, :orange_output, :integer
  end
end
