class AddStoreIdToDispatch < ActiveRecord::Migration[5.0]
  def change
    add_column :dispatches, :store_id, :integer
  end
end
