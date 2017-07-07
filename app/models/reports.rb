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

	def stock_status_reports hub, warehouse, program, commodity

    	@donation_journal = Journal.find_by({'code': :donation})
    	@purchase_journal = Journal.find_by({'code': :purchase})
    	@loan_journal = Journal.find_by({'code': :loan})
    	@goods_received_journal = Journal.find_by({'code': :goods_received})
    	@goods_issue_journal = Journal.find_by({'code': :goods_issue})
    	@delivery_journal = Journal.find_by({'code': :delivery})

    	@receivable_account = Account.find_by({'code': :receivable})
    	@stock_account = Account.find_by({'code': :stock})
    	@dispatched_account = Account.find_by({'code': :dispatched})
    	@delivered_account = Account.find_by({'code': :delivered})

    	@where_clause = ''
    	@group_by_clause = ''

    	if( hub.present?  )
	  		@where_clause += ' AND hub_id = ' + hub.to_s 
  		end
	  	if ( program.present? )  
	  		@where_clause += ' AND program_id = ' + program.to_s
  		end
		if ( warehouse.present? )
			@where_clause += ' AND warehouse_id = ' + warehouse.to_s
		end
		if ( commodity.present? )
			@where_clause += ' AND commodity_id = ' + commodity.to_s
		end

		if( hub.present?  )
	  		@group_by_clause += ' hub_id, commodity_id '
	  		@rpi_select = ' hub_id, commodity_id, SUM(quantity) AS received '
	  		@epi_select = ' hub_id, commodity_id, ABS(SUM(quantity)) AS expected '
	  		@join_on = ' RPI.hub_id = EPI.hub_id AND RPI.commodity_id = EPI.commodity_id '
  		else
  			@group_by_clause += ' commodity_id ' 
  			@rpi_select = ' commodity_id, SUM(quantity) AS received '
	  		@epi_select = ' commodity_id, ABS(SUM(quantity)) AS expected '
	  		@join_on = ' RPI.commodity_id = EPI.commodity_id '
		end

		@result = ActiveRecord::Base.connection
			.exec_query("SELECT commodities.name AS commodity, EPI.expected, RPI.received
			FROM
			(Select #{@epi_select} from posting_items 
			WHERE (journal_id = #{@donation_journal.id.to_s} OR journal_id = #{@purchase_journal.id.to_s} 
				OR journal_id = #{@loan_journal.id.to_s} ) AND account_id = #{@receivable_account.id.to_s} 
				#{@where_clause} 
			GROUP BY #{@group_by_clause}) EPI
			LEFT JOIN
			(Select #{@rpi_select} from posting_items 
			WHERE journal_id = #{@goods_received_journal.id.to_s} AND account_id = #{@stock_account.id.to_s} 
			#{@where_clause} 
			GROUP BY #{@group_by_clause}) RPI
			ON #{@join_on}
			LEFT JOIN commodities on commodities.id =EPI.commodity_id")
		# render :text => @result.inspect
	end 
end