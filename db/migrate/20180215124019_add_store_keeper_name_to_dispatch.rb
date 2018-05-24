class AddStoreKeeperNameToDispatch < ActiveRecord::Migration[5.0]
  def up
  	if !column_exists?(:dispatches, :storekeeper_name)
      add_column :dispatches, :storekeeper_name, :string
    end
  end

  def down
  	if column_exists?(:dispatches, :storekeeper_name)
      drop_column :dispatches, :storekeeper_name, :string
    end
  end
end
