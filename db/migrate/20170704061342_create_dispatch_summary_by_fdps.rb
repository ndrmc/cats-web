class CreateDispatchSummaryByFdps < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      CREATE VIEW dispatch_summary_by_fdps AS
        SELECT allo.fdp_id AS AlloFDP, allo.operation_id AS AllOpID, allo.commodity_id AS AlloCommID, 
        	allo.commodity_name,
				allo.allocated, allo.requisition_no AS AlloReqNo,
			disp.fdp_id AS DispFDP, disp.operation_id AS DispOpID, disp.commodity_id AS DispCommID, 
				disp.dispatched, disp.requisition_number AS DispReqNo,
			allo.fdp_name, allo.woreda_id, allo.woreda_name, allo.zone_id, allo.zone_name, allo.region_id, 
			allo.region_name
		FROM
		(SELECT ABS(SUM(amount)) AS allocated, operation_id, requisitions.commodity_id, fdp_id, 
			requisitions.requisition_no, commodities.name AS commodity_name,
			fdps.name AS fdp_name, woreda.id AS woreda_id, woreda.name AS woreda_name, zone.id AS zone_id, 
			zone.name AS zone_name, region.id AS region_id, region.name AS region_name
			  FROM requisitions
			LEFT JOIN requisition_items 
				ON public.requisitions.id = requisition_items.requisition_id
			LEFT JOIN commodities 
				ON requisitions.commodity_id = commodities.id
			LEFT JOIN fdps
				ON requisition_items.fdp_id = fdps.id
			LEFT JOIN locations woreda
				ON fdps.location_id = woreda.id
			LEFT JOIN locations zone
				ON woreda.parent_node_id = zone.id
			LEFT JOIN locations region
				ON zone.parent_node_id = region.id
			GROUP BY operation_id, requisitions.commodity_id, fdp_id, requisitions.requisition_no, 
				fdps.name, woreda.id, woreda.name, zone.id, zone.name, region.id, region.name, 
				commodity_name) AS allo
		LEFT JOIN	
		(SELECT ABS(SUM(d_items.quantity)) AS dispatched, dispatches.fdp_id, dispatches.operation_id, 
			d_items.commodity_id, commodities.name AS commodity_name,
				dispatches.requisition_number
			FROM dispatch_items d_items
			LEFT JOIN dispatches
				ON d_items.dispatch_id = dispatches.id
			LEFT JOIN commodities 
				ON d_items.commodity_id = commodities.id
			LEFT JOIN fdps
				ON dispatches.fdp_id = fdps.id
			LEFT JOIN locations woreda
				ON fdps.location_id = woreda.id
			LEFT JOIN locations zone
				ON woreda.parent_node_id = zone.id
			LEFT JOIN locations region
				ON zone.parent_node_id = region.id
			GROUP BY dispatches.fdp_id, dispatches.operation_id, d_items.commodity_id, commodity_name,
				dispatches.requisition_number) AS disp
		ON allo.fdp_id = disp.fdp_id AND allo.operation_id = disp.operation_id AND 
			allo.commodity_id = disp.commodity_id AND 
			allo.requisition_no = disp.requisition_number
    SQL
  end

  def down
    execute "DROP VIEW dispatch_summary_by_fdps"
  end
end
