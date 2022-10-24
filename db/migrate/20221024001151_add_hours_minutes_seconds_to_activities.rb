class AddHoursMinutesSecondsToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :hours, :integer
    add_column :activities, :minutes, :integer
    add_column :activities, :seconds, :integer
  end
end
