class Reports

	def journal_reports hub, program, commodity, operation

    	donation_journal = Journal.find_by({'code': :donation})
    	purchase_journal = Journal.find_by({'code': :purchase})
    	loan_journal = Journal.find_by({'code': :loan})
    	goods_received_journal = Journal.find_by({'code': :goods_received})
    	goods_issue_journal = Journal.find_by({'code': :goods_issue})
    	delivery_journal = Journal.find_by({'code': :delivery})

    	receivable_account = Account.find_by({'code': :receivable})
    	stock_account = Account.find_by({'code': :stock})
    	dispatched_account = Account.find_by({'code': :dispatched})
    	delivered_account = Account.find_by({'code': :delivered})

		if( hub.present? && program.present? && commodity.present? && operation.present? )
	  		@result = ActiveRecord::Base.connection
			.exec_query('SELECT hubs.name AS hub, commodities.name AS commodity, donors.name AS donor, programs.name AS program, 
				EPI.expected, RPI.received, DiPI.dispatched, DePI.delivered, (DiPI.dispatched - DePI.delivered)  AS git
			FROM
			(Select hub_id, program_id, commodity_id, donor_id, ABS(SUM(quantity)) AS expected from posting_items 
				WHERE (journal_id = ' + donation_journal.id.to_s + ' OR journal_id = ' + purchase_journal.id.to_s + 
				' OR journal_id = ' + loan_journal.id.to_s + ') AND account_id = ' + receivable_account.id.to_s + '
				AND hub_id = ' + hub.to_s + ' AND operation_id = ' + operation.to_s +
				' AND program_id = ' + program.to_s + ' AND commodity_id = ' + commodity.to_s + '
				GROUP BY hub_id, program_id, commodity_id, donor_id) EPI		
			LEFT JOIN	
				(Select hub_id, program_id, commodity_id, donor_id, SUM(quantity) AS received from posting_items 
				WHERE journal_id = ' + goods_received_journal.id.to_s + ' AND account_id = ' + stock_account.id.to_s + ' 
				AND hub_id = ' + hub.to_s + ' AND operation_id = ' + operation.to_s + 
				' AND program_id = ' + program.to_s + ' AND commodity_id = ' + commodity.to_s + '
				GROUP BY hub_id, program_id, commodity_id, donor_id) RPI
					ON RPI.hub_id = EPI.hub_id AND RPI.program_id = EPI.program_id AND RPI.commodity_id = EPI.commodity_id
							AND RPI.donor_id = EPI.donor_ID
			LEFT JOIN
				(Select hub_id, program_id, commodity_id, donor_id, SUM(quantity) AS dispatched from posting_items 
				WHERE journal_id = ' + goods_issue_journal.id.to_s + ' AND account_id = ' + dispatched_account.id.to_s + ' 
				AND hub_id = ' + hub.to_s + ' AND operation_id = ' + operation.to_s + 
				' AND program_id = ' + program.to_s + ' AND commodity_id = ' + commodity.to_s + ' 
				GROUP BY hub_id, program_id, commodity_id, donor_id) DiPI
					ON DiPI.hub_id = EPI.hub_id AND DiPI.program_id = EPI.program_id AND DiPI.commodity_id = EPI.commodity_id
						AND DiPI.donor_id = EPI.donor_ID	
			LEFT JOIN
				(Select hub_id, program_id, commodity_id, donor_id, ABS(SUM(quantity)) AS delivered from posting_items 
				WHERE journal_id = ' + delivery_journal.id.to_s + ' AND account_id = ' + delivered_account.id.to_s + ' 
				AND hub_id = ' + hub.to_s + ' AND operation_id = ' + operation.to_s + 
				' AND program_id = ' + program.to_s + ' AND commodity_id = ' + commodity.to_s + ' 
				GROUP BY hub_id, program_id, commodity_id, donor_id) DePI
					ON DePI.hub_id = EPI.hub_id AND DePI.program_id = EPI.program_id AND DePI.commodity_id = EPI.commodity_id
						AND DePI.donor_id = EPI.donor_ID
			LEFT JOIN hubs on hubs.id = EPI.hub_id
			LEFT JOIN programs on programs.id =EPI.program_id	
			LEFT JOIN commodities on commodities.id =EPI.commodity_id	
			LEFT JOIN donors on donors.id =EPI.donor_id')
		else
		  	@result = ActiveRecord::Base.connection
		  		.exec_query('SELECT hubs.name AS hub, commodities.name AS commodity, donors.name AS donor, programs.name AS program, 
				EPI.expected, RPI.received, DiPI.dispatched, DePI.delivered, (DiPI.dispatched - DePI.delivered)  AS git
				FROM
				(Select hub_id, program_id, commodity_id, donor_id, ABS(SUM(quantity)) AS expected from posting_items 
					WHERE (journal_id = ' + donation_journal.id.to_s + ' OR journal_id = ' + purchase_journal.id.to_s + 
					' OR journal_id = ' + loan_journal.id.to_s + ') AND account_id = ' + receivable_account.id.to_s + '
					GROUP BY hub_id, program_id, commodity_id, donor_id) EPI		
				LEFT JOIN	
					(Select hub_id, program_id, commodity_id, donor_id, SUM(quantity) AS received from posting_items 
					WHERE journal_id = ' + goods_received_journal.id.to_s + ' AND account_id = ' + stock_account.id.to_s + ' 
					GROUP BY hub_id, program_id, commodity_id, donor_id) RPI
						ON RPI.hub_id = EPI.hub_id AND RPI.program_id = EPI.program_id AND RPI.commodity_id = EPI.commodity_id
								AND RPI.donor_id = EPI.donor_ID
				LEFT JOIN
					(Select hub_id, program_id, commodity_id, donor_id, SUM(quantity) AS dispatched from posting_items 
					WHERE journal_id = ' + goods_issue_journal.id.to_s + ' AND account_id = ' + dispatched_account.id.to_s + ' 
					GROUP BY hub_id, program_id, commodity_id, donor_id) DiPI
						ON DiPI.hub_id = EPI.hub_id AND DiPI.program_id = EPI.program_id AND DiPI.commodity_id = EPI.commodity_id
							AND DiPI.donor_id = EPI.donor_ID	
				LEFT JOIN
					(Select hub_id, program_id, commodity_id, donor_id, ABS(SUM(quantity)) AS delivered from posting_items 
					WHERE journal_id = ' + delivery_journal.id.to_s + ' AND account_id = ' + delivered_account.id.to_s + '  
					GROUP BY hub_id, program_id, commodity_id, donor_id) DePI
						ON DePI.hub_id = EPI.hub_id AND DePI.program_id = EPI.program_id AND DePI.commodity_id = EPI.commodity_id
							AND DePI.donor_id = EPI.donor_ID
				LEFT JOIN hubs on hubs.id = EPI.hub_id
				LEFT JOIN programs on programs.id =EPI.program_id	
				LEFT JOIN commodities on commodities.id =EPI.commodity_id	
				LEFT JOIN donors on donors.id =EPI.donor_id')
		end
	end 

	#### Dispatch Reports - Begin #######################################################
		def dispatch_reports_by_region operation
			@result = ActiveRecord::Base.connection
				.exec_query('SELECT allo.region_id AS location_id, allo.region_name AS region_name, allo.allocated, disp.dispatched, 
								operation_id
							FROM
							((SELECT ABS(SUM(amount)) AS allocated, operation_id, region.id AS region_id, region.name AS region_name
							  FROM requisitions
							LEFT JOIN requisition_items 
							ON public.requisitions.id = requisition_items.requisition_id
							LEFT JOIN locations zone
							ON requisitions.zone_id = zone.id
							LEFT JOIN locations region
							ON zone.parent_node_id = region.id
							GROUP BY operation_id, region.id, region.name) allo
							LEFT JOIN
							(SELECT ABS(SUM(d_items.quantity)) AS dispatched, region.id AS region_id
							FROM dispatch_items d_items
							LEFT JOIN dispatches
							ON d_items.dispatch_id = dispatches.id
							LEFT JOIN fdps
							ON dispatches.fdp_id = fdps.id
							LEFT JOIN locations woreda
							ON fdps.location_id = woreda.id
							LEFT JOIN locations zone
							ON woreda.parent_node_id = zone.id
							LEFT JOIN locations region
							ON zone.parent_node_id = region.id
							GROUP BY region.id) disp
							ON allo.region_id = disp.region_id)
							WHERE operation_id = ' + operation.to_s + '')
		end

		def dispatch_reports_by_zone operation, region
			@result = ActiveRecord::Base.connection
				.exec_query('SELECT zone.name AS location, allo.requisition_no AS requisition, commodity.name AS commodity, allo.allocated, 
								disp.dispatched, operation_id, region_id, allo.zone_id AS location_id
							FROM
							((SELECT requisition_no, commodity_id, zone_id, ABS(SUM(amount)) AS allocated, operation_id, 
								region.id AS region_id
							  FROM requisitions
							LEFT JOIN requisition_items 
							ON public.requisitions.id = requisition_items.requisition_id
							LEFT JOIN locations zone
							ON requisitions.zone_id = zone.id
							LEFT JOIN locations region
							ON zone.parent_node_id = region.id
							GROUP BY requisition_no, commodity_id, zone_id, operation_id, region.id) allo
							LEFT JOIN
							(SELECT woreda.parent_node_id AS zone_id, ABS(SUM(d_items.quantity)) AS dispatched, 
								dispatches.requisition_number AS req_no 
							FROM dispatch_items d_items
							LEFT JOIN dispatches
							ON d_items.dispatch_id = dispatches.id
							LEFT JOIN fdps
							ON dispatches.fdp_id = fdps.id
							LEFT JOIN locations woreda
							ON fdps.location_id = woreda.id
							LEFT JOIN locations zone
							ON woreda.parent_node_id = zone.id
							LEFT JOIN locations region
							ON zone.parent_node_id = region.id
							GROUP BY zone_id, req_no) disp
							ON allo.requisition_no = disp.req_no AND allo.zone_id = disp.zone_id)
							LEFT JOIN locations zone
							ON zone.id = allo.zone_id
							LEFT JOIN commodities commodity
							ON commodity.id = allo.commodity_id
							WHERE region_id = ' + region.to_s + ' AND operation_id = ' + operation.to_s)
		end

		def dispatch_reports_by_woreda operation, zone
			@result = ActiveRecord::Base.connection
			.exec_query('SELECT allo.zone_id AS zone_id, allo.zone_name AS zone_name, allo.requisition_no AS requisition, 
							commodity.name AS commodity, 
							allo.allocated, disp.dispatched, operation_id, region_id, allo.woreda_id AS location_id, allo.woreda_name AS location
						FROM
						((SELECT requisition_no, commodity_id, zone_id, zone.name AS zone_name, ABS(SUM(amount)) AS allocated, 
							operation_id, region.id AS region_id, woreda.id AS woreda_id, woreda.name AS woreda_name
						  FROM requisitions
						LEFT JOIN requisition_items 
						ON public.requisitions.id = requisition_items.requisition_id
						LEFT JOIN fdps
						On fdps.id = requisition_items.fdp_id
						LEFT JOIN locations woreda
						ON woreda.id = fdps.location_id
						LEFT JOIN locations zone
						ON requisitions.zone_id = zone.id
						LEFT JOIN locations region
						ON zone.parent_node_id = region.id
						GROUP BY requisition_no, commodity_id, zone_id, operation_id, region.id, woreda.id, woreda_name, 
							zone_name) allo
						LEFT JOIN
						(SELECT zone.id AS zone_id, woreda.id AS woreda_id, ABS(SUM(d_items.quantity)) AS dispatched, 
							dispatches.requisition_number AS req_no 
						FROM dispatch_items d_items
						LEFT JOIN dispatches
						ON d_items.dispatch_id = dispatches.id
						LEFT JOIN fdps
						ON dispatches.fdp_id = fdps.id
						LEFT JOIN locations woreda
						ON fdps.location_id = woreda.id
						LEFT JOIN locations zone
						ON woreda.parent_node_id = zone.id
						LEFT JOIN locations region
						ON zone.parent_node_id = region.id
						GROUP BY woreda_id, zone_id, req_no, woreda.id) disp
						ON allo.requisition_no = disp.req_no AND allo.zone_id = disp.zone_id)
						LEFT JOIN commodities commodity
						ON commodity.id = allo.commodity_id
						WHERE allo.zone_id = ' + zone.to_s + ' AND operation_id = ' + operation.to_s)
		end	

		def dispatch_reports_by_fdp operation, woreda
			@result =ActiveRecord::Base.connection
			.exec_query('SELECT allo.zone_id AS zone_id, allo.zone_name AS zone_name, allo.requisition_no AS requisition, 
					commodity.name AS commodity, 
				allo.allocated, disp.dispatched, operation_id, region_id, allo.woreda_id, allo.woreda_name, allo.fdp_id AS location_id, 
					allo.fdp_name AS location
			FROM
			((SELECT requisition_no, commodity_id, zone_id, zone.name AS zone_name, ABS(SUM(amount)) AS allocated, operation_id, 
				region.id AS region_id, woreda.id AS woreda_id, woreda.name AS woreda_name, fdps.id AS fdp_id, 
					fdps.name AS fdp_name
			  FROM requisitions
			LEFT JOIN requisition_items 
			ON public.requisitions.id = requisition_items.requisition_id
			LEFT JOIN fdps
			On fdps.id = requisition_items.fdp_id
			LEFT JOIN locations woreda
			ON woreda.id = fdps.location_id
			LEFT JOIN locations zone
			ON requisitions.zone_id = zone.id
			LEFT JOIN locations region
			ON zone.parent_node_id = region.id
			GROUP BY requisition_no, commodity_id, zone_id, operation_id, region.id, woreda.id, woreda_name, zone_name, 
			fdps.id, fdps.name) allo
			LEFT JOIN
			(SELECT zone.id AS zone_id, woreda.id AS woreda_id, ABS(SUM(d_items.quantity)) AS dispatched, 
				dispatches.requisition_number AS req_no, fdps.id AS fdp_id, fdps.name AS fdp_name
			FROM dispatch_items d_items
			LEFT JOIN dispatches
			ON d_items.dispatch_id = dispatches.id
			LEFT JOIN fdps
			ON dispatches.fdp_id = fdps.id
			LEFT JOIN locations woreda
			ON fdps.location_id = woreda.id
			LEFT JOIN locations zone
			ON woreda.parent_node_id = zone.id
			LEFT JOIN locations region
			ON zone.parent_node_id = region.id
			GROUP BY woreda_id, zone_id, req_no, woreda.id, fdps.id, fdps.name) disp
			ON allo.requisition_no = disp.req_no AND allo.zone_id = disp.zone_id)
			LEFT JOIN commodities commodity
			ON commodity.id = allo.commodity_id
			WHERE allo.woreda_id = ' + woreda.to_s + ' AND operation_id = ' + operation.to_s)

		end		

		def dispatch_reports
			@result = []
		end

	#### Dispatch Reports - End #########################################################
end