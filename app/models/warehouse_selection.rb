class WarehouseSelection < ApplicationRecord
	belongs_to :location
	belongs_to :warehouse

	def filter_by_region(region)
		WarehouseSelection.joins(:location, warehouse: :hub).select(:id, 'warehouses.name AS warehouse_name', :'warehouses.location_id', 'locations.name AS woreda_name', 'hubs.name AS hub_name', :estimated_qty)
			.find_each do |warehouse_selection|
				region_id = Location.find(warehouse_selection.location_id).parent.parent.location_id
				if(region_id == region)
					result << warehouse_selection
				end
			end
	end
end
