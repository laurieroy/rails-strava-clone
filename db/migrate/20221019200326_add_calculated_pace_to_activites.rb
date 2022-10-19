class AddCalculatedPaceToActivites < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :calculated_pace, :decimal
  end
end
