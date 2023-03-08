class RenameDistanceToDistanceInMilesOnTotals < ActiveRecord::Migration[6.1]
  def change
    StrongMigrations.disable_check(:rename_column)
    rename_column(:totals, :distance, :distance_in_miles)
  end
end
