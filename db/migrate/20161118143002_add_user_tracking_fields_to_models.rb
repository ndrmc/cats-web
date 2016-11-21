class AddUserTrackingFieldsToModels < ActiveRecord::Migration[5.0]
  def change

  	[
				:bid_plan_items,
				:bid_plans,
				:bids,
				:bid_submissions,
				:bid_winners,
				:commodity_categories,
				:commodities,
				:contracts,
				:currencies,
				:donors,
				:fdp_contacts,
				:fdps,
				:fscd_annual_plans,
				:fscd_plan_items,
				:fund_sources,
				:fund_types,
				:gift_certificate_items,
				:gift_certificates,
				:hrd_items,
				:hrds,
				:hubs,
				:locations,
				:mode_of_transports,
				:operations,
				:programs,
				:quotations,
				:ration_items,
				:rations,
				:requisition_items,
				:requisitions,
				:seasons,
				:warehouses,
				:store_owners,
				:stores,
				:transporter_addresses,
				:transporters,
				:transport_order_items,
				:transport_orders,
				:transport_requisition_items,
				:transport_requisitions,
				:unit_of_measures,
				:uom_categories,
				:users
				].each do |table|

				add_column table, :created_by, :integer
				add_column table, :modified_by, :integer
				add_column table, :deleted, :boolean, :default => false
		end
  end
end
