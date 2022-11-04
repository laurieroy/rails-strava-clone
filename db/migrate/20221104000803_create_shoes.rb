class CreateShoes < ActiveRecord::Migration[6.1]
  def change
    create_table :shoes do |t|
      t.string :name, null: false
      t.decimal :distance_in_miles, precision: 6, scale: 2, default: 0
      t.boolean :retired, default: 0, null: false
      t.integer :replacement_miles

      t.timestamps
    end
  end
end
