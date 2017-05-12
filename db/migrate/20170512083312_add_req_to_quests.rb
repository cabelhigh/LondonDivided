class AddReqToQuests < ActiveRecord::Migration[5.0]
  def change
    add_column :quests, :req, :text
  end
end
