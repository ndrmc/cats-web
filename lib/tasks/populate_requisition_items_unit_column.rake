namespace :cats do
	namespace :requisition do
		desc "Populates fdp_operations_log table with each participating documents"
		task populate_requisition_items_unit: :environment do
			puts "Start populating requisition_items unit_of_measure column......"
			RequisitionItem.find_each do |requisition_item|
				kg_unit_obj = UnitOfMeasure.where(:code => "KG").first
				mt_unit_obj = UnitOfMeasure.where(:code => "MT").first
				if(requisition_item.created_at > Time.parse("2017-03-23 17:10:31.153"))					
					requisition_item.unit_of_measure_id = kg_unit_obj.id
					requisition_item.save
				else
					requisition_item.unit_of_measure_id = mt_unit_obj.id
					requisition_item.save
				end
			end
			puts "Finished populating requisition_items unit_of_measure column"
		end
	end
end