class AddNumTimesHourToProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :properties, :num_times_hour, :integer
  end
end
