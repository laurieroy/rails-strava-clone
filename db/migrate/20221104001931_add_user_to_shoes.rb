class AddUserToShoes < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_reference :shoes, :user, null: false, index: {algorithm: :concurrently}
  end
end
