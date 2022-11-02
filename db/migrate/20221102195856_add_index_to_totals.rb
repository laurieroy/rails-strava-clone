class AddIndexToTotals < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :totals, :start_date, algorithm: :concurrently
    add_index :totals, :range, algorithm: :concurrently
  end
end
