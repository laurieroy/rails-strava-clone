class CreateTotals < ActiveRecord::Migration[6.1]
  def change
    create_table :totals do |t|
      t.references :user, null: false, foreign_key: true
      t.date :start_date, null: false
      t.integer :duration, default: 0
      t.integer :range, null: false
      t.decimal :distance, default: 0

      t.timestamps
    end
  end
end
