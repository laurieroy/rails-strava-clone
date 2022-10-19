class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.integer :duration
      t.integer :category, default: 0, null: false
      t.decimal :distance, precision: 5, scale: 2
      t.integer :difficulty
      t.integer :unit
      t.references :user, null: false, foreign_key: true
    
      t.datetime :date, null: false

      t.timestamps
    end
  end
end
