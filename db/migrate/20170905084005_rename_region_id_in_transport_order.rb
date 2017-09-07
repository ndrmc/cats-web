class RenameRegionIdInTransportOrder < ActiveRecord::Migration[5.0]
  def up
  	if column_exists?(:transport_orders, :region_id)
		rename_column :transport_orders, :region_id, :location_id
	end
  end

  def down
  	if column_exists?(:transport_orders, :location_id)
		rename_column :transport_orders, :location_id, :region_id
	end
  end
end
