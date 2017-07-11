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
			@result = DispatchSummaryByFdp.select("region_id AS location_id, region_name AS location, 
				allo_op_id AS operation, SUM(allocated) AS allocated, SUM(dispatched) AS dispatched")
		    .group('region_id, region_name, allo_op_id')
		    .where('allo_op_id = ' + operation.to_s)
		    .order('region_name ASC')
			
		end

		def dispatch_reports_by_zone operation, region
			@result = DispatchSummaryByFdp.select("zone_id AS location_id, zone_name AS location, 
				allo_op_id AS operation_id, allo_req_no as requisition, commodity_name AS commodity, 
				SUM(allocated) AS allocated, SUM(dispatched) AS dispatched")
		    .group('zone_id, zone_name, allo_op_id, allo_req_no, commodity_name')
		    .where('allo_op_id = ' + operation.to_s + ' AND region_id = ' + region.to_s)
		    .order('zone_name ASC')
		end

		def dispatch_reports_by_woreda operation, zone
			@result = DispatchSummaryByFdp.select("woreda_id AS location_id, woreda_name AS location, 
				allo_op_id AS operation_id, allo_req_no as requisition, commodity_name AS commodity, 
				SUM(allocated) AS allocated, SUM(dispatched) AS dispatched")
		    .group('woreda_id, woreda_name, allo_op_id, allo_req_no, commodity_name')
		    .where('allo_op_id = ' + operation.to_s + ' AND zone_id = ' + zone.to_s)
		    .order('woreda_name ASC')
		end	

		def dispatch_reports_by_fdp operation, woreda
			@result = DispatchSummaryByFdp.select("allo_fdp AS location_id, fdp_name AS location, 
				allo_op_id AS operation_id, allo_req_no as requisition, commodity_name AS commodity, 
				SUM(allocated) AS allocated, SUM(dispatched) AS dispatched")
		    .group('allo_fdp, fdp_name, allo_op_id, allo_req_no, commodity_name')
		    .where('allo_op_id = ' + operation.to_s + ' AND woreda_id = ' + woreda.to_s)
		    .order('fdp_name ASC')

		end		

		def dispatch_reports
			@result = []
		end

	#### Dispatch Reports - End #########################################################
end