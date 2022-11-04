class AddShoeToActivities < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!
  
  def change
    add_reference :activities, :shoe, index: {algorithm: :concurrently}
  end
end
