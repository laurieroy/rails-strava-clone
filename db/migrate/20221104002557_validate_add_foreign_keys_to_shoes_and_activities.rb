class ValidateAddForeignKeysToShoesAndActivities < ActiveRecord::Migration[6.1]
  def change
    validate_foreign_key :activities, :shoes
  end
end
