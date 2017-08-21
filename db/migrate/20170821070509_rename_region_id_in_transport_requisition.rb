class RenameRegionIdInTransportRequisition < ActiveRecord::Migration[5.0]
  def up
  	if column_exists?(:transport_requisitions, :region_id)
		rename_column :transport_requisitions, :region_id, :location_id
	end
  end

  def down
  	if column_exists?(:transport_requisitions, :location_id)
		rename_column :transport_requisitions, :location_id, :region_id
	end
  end
end
