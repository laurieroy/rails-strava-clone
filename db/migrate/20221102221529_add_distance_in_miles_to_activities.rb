class AddDistanceInMilesToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :distance_in_miles, :decimal, precision: 6, scale: 2
  end
end
