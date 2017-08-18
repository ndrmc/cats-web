class RenameWoredaIdInWarehouseSelection < ActiveRecord::Migration[5.0]
  def up
  	if column_exists?(:warehouse_selections, :woreda_id)
		rename_column :warehouse_selections, :woreda_id, :location_id
	end
  end

  def down
  	if column_exists?(:warehouse_selections, :location_id)
		rename_column :warehouse_selections, :location_id, :woreda_id
	end
  end
end
