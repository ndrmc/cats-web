class Reports

	def journal_reports hub, warehouse

    	stock_account = Account.find_by({'code': :stock})
		 
		if( hub.present?  && warehouse.present? )
	  		@result = ActiveRecord::Base.connection
										.exec_query('select h.name as hub, w.name as warehouse, c.name as commodity, sum(pi.quantity) as balance
							from posting_items pi
							inner join commodities c on c.id = pi.commodity_id
							inner join hubs h on h.id = pi.hub_id
							inner join warehouses w on w.id = pi.warehouse_id
							where pi.account_id = ' + stock_account.id.to_s  + '  and pi.hub_id = ' +   hub.to_s + ' and pi.warehouse_id = ' +  warehouse.to_s + '
							group by hub, warehouse, commodity')
		else
		  	@result = ActiveRecord::Base.connection
		  		.exec_query('')
		end
	end 


	def stock_status_by_commodity_type hub, warehouse
		stock_account = Account.find_by({'code': :stock})
		 
		if( hub.present?  && warehouse.present? )
			@result = StockReportByCommodity.group('commodity_category,commodity').select('commodity,commodity_category, sum(balance) as balance').where(:'p_id' => stock_account, :'hub_id' => hub ,:'warehouse_id' => warehouse)
		elsif (hub.present?)
			@result = StockReportByCommodity.group('commodity_category,commodity').select('commodity,commodity_category, sum(balance) as balance').where(:'p_id' => stock_account, :'hub_id' => hub)
		else
		  	@result = StockReportByCommodity.group('commodity_category,commodity').select('commodity,commodity_category, sum(balance) as balance').where(:'p_id' => stock_account)
		end
	end


	def stock_status_by_project_code hub, warehouse
		stock_account = Account.find_by({'code': :stock})
		if( hub.present?  && warehouse.present? )
	  		@result = ActiveRecord::Base.connection
			.exec_query('select p.project_code as project_code, cs.name as commodity_source, h.name as hub, w.name as warehouse, c.name as commodity, sum(pi.quantity) as balance
						from posting_items pi
						inner join projects p on p.id = pi.project_id
						inner join commodity_sources cs on cs.id = p.commodity_source_id
						inner join commodities c on c.id = pi.commodity_id
						inner join hubs h on h.id = pi.hub_id
						inner join warehouses w on w.id = pi.warehouse_id
						where pi.account_id  = ' + stock_account.id.to_s  + '
						and pi.hub_id = ' +   hub.to_s + ' 
						and pi.warehouse_id = ' +  warehouse.to_s + '
						group by commodity_source, hub, warehouse, commodity, project_code')
		elsif (hub.present?)
			@result = ActiveRecord::Base.connection
										.exec_query('select p.project_code as project_code, cs.name as commodity_source, h.name as hub, w.name as warehouse, c.name as commodity, sum(pi.quantity) as balance
													from posting_items pi
													inner join projects p on p.id = pi.project_id
													inner join commodity_sources cs on cs.id = p.commodity_source_id
													inner join commodities c on c.id = pi.commodity_id
													inner join hubs h on h.id = pi.hub_id
													inner join warehouses w on w.id = pi.warehouse_id
													where pi.account_id  = ' + stock_account.id.to_s  + '
													and pi.hub_id = ' +   hub.to_s + ' 
													group by commodity_source, hub, warehouse, commodity, project_code')
		else
		  	@result = ActiveRecord::Base.connection
		  		.exec_query('select p.project_code as project_code, cs.name as commodity_source, h.name as hub, w.name as warehouse, c.name as commodity, sum(pi.quantity) as balance
													from posting_items pi
													inner join projects p on p.id = pi.project_id
													inner join commodity_sources cs on cs.id = p.commodity_source_id
													inner join commodities c on c.id = pi.commodity_id
													inner join hubs h on h.id = pi.hub_id
													inner join warehouses w on w.id = pi.warehouse_id
													where pi.account_id  = ' + stock_account.id.to_s  + '
													group by commodity_source, hub, warehouse, commodity, project_code')
		end
	end
	

	def received_stock_by_project_code (from_date, to_date, hub, warehouse)
		receipt_journal = Journal.find_by({'code': :goods_received})
		stock_account = Account.find_by({'code': :stock})		

		if( from_date.present? && to_date.present? && hub.present?  && warehouse.present? )
			@result = PostingItem.joins(:project, :commodity, :posting).joins("INNER JOIN receipts on receipts.id = postings.document_id").where(journal_id: receipt_journal, account_id: stock_account, hub: hub, warehouse: warehouse).where("receipts.received_Date > ? AND receipts.received_Date < ?", from_date, to_date).group(:'projects.project_code', :'commodities.name').select('projects.project_code, commodities.name, SUM(posting_items.quantity)')
		elsif ( from_date.present? && to_date.present? && hub.present? )
			@result = PostingItem.joins(:project, :commodity, :posting).joins("INNER JOIN receipts on receipts.id = postings.document_id").where(journal_id: receipt_journal, account_id: stock_account, hub: hub).where("receipts.received_Date > ? AND receipts.received_Date < ?", from_date, to_date).group(:'projects.project_code', :'commodities.name').select('projects.project_code, commodities.name, SUM(posting_items.quantity)')
		elsif ( from_date.present? && to_date.present? )
			@result = PostingItem.joins(:project, :commodity, :posting).joins("INNER JOIN receipts on receipts.id = postings.document_id").where(journal_id: receipt_journal, account_id: stock_account).where("receipts.received_Date > ? AND receipts.received_Date < ?", from_date, to_date).group(:'projects.project_code', :'commodities.name').select('projects.project_code, commodities.name, SUM(posting_items.quantity)')
		else
			@result = PostingItem.joins(:project, :commodity).where(journal_id: receipt_journal, account_id: stock_account).group(:'projects.project_code', :'commodities.name').select('projects.project_code, commodities.name, SUM(posting_items.quantity)')
		end
	end

	def received_stock_by_commodity_source (from_date, to_date, hub, warehouse)
		receipt_journal = Journal.find_by({'code': :goods_received})
		stock_account = Account.find_by({'code': :stock})		

		if( from_date.present? && to_date.present? && hub.present?  && warehouse.present? )
			@result = PostingItem.joins(:project, :commodity, :posting).joins("INNER JOIN receipts on receipts.id = postings.document_id INNER JOIN commodity_sources ON commodity_sources.id = receipts.commodity_source_id").where(journal_id: receipt_journal, account_id: stock_account, hub: hub, warehouse: warehouse).where("receipts.received_Date > ? AND receipts.received_Date < ?", from_date, to_date).group(:'commodity_sources.name').select('commodity_sources.name, SUM(posting_items.quantity)')
		elsif ( from_date.present? && to_date.present? && hub.present? )
			@result = PostingItem.joins(:project, :commodity, :posting).joins("INNER JOIN receipts on receipts.id = postings.document_id INNER JOIN commodity_sources ON commodity_sources.id = receipts.commodity_source_id").where(journal_id: receipt_journal, account_id: stock_account, hub: hub).where("receipts.received_Date > ? AND receipts.received_Date < ?", from_date, to_date).group(:'commodity_sources.name').select('commodity_sources.name, SUM(posting_items.quantity)')
		elsif ( from_date.present? && to_date.present? )
			@result = PostingItem.joins(:project, :commodity, :posting).joins("INNER JOIN receipts on receipts.id = postings.document_id INNER JOIN commodity_sources ON commodity_sources.id = receipts.commodity_source_id").where(journal_id: receipt_journal, account_id: stock_account).where("receipts.received_Date > ? AND receipts.received_Date < ?", from_date, to_date).group(:'commodity_sources.name').select('commodity_sources.name, SUM(posting_items.quantity)')
		else
			@result = PostingItem.joins(:project, :commodity, :posting).joins("INNER JOIN receipts on receipts.id = postings.document_id INNER JOIN commodity_sources ON commodity_sources.id = receipts.commodity_source_id").where(journal_id: receipt_journal, account_id: stock_account).group(:'commodity_sources.name').select('commodity_sources.name, SUM(posting_items.quantity)')
		end
	end
	
	def dispatch_report_by_project hub, warehouse, from_date, to_date
		 
    	  dispatched_account = Account.find_by({'code': :dispatched})
    	  good_issue_journal = Journal.find_by({'code': :goods_issue})
		  flag = 0
		  @result = DispatchReportByProject.where(:'account_id' => dispatched_account.id, :'journal_id' => good_issue_journal.id)
	    if( hub.present?  && warehouse.present?  && from_date.present? && to_date.present?)
			@result = @result.where(:'hub_id' => hub , :'warehouse_id' => warehouse).where('dispatch_date >= ? and dispatch_date <= ?',from_date,to_date )
			flag = 1
		elsif (hub.present? && from_date.present? && to_date.present?)
			@result = @result.where(:'hub_id' => hub).where('dispatch_date >= ? and dispatch_date <= ?',from_date,to_date )
			flag = 1
		elsif( hub.present?  && warehouse.present?)
			@result = @result.where(:'hub_id' => hub , :'warehouse_id' => warehouse)
			flag = 1
		elsif (hub.present?)
			@result = @result.where(:'hub_id' => hub)
			flag = 1
		elsif (from_date.present? && to_date.present?)
		  	@result = @result.where('dispatch_date >= ? and dispatch_date <= ?',from_date,to_date )
			flag = 1
		else
			@result = @result.group('project_code, commodity,hub,warehouse').select('project_code,hub,warehouse, commodity, sum(balance) as balance')
		end
		
		if (flag)
			@result = @result.group('project_code, commodity,hub,warehouse').select('project_code,hub,warehouse, commodity, sum(balance) as balance')
		end
		 
	end



	def stock_summary_by_project_code(hub, warehouse)
		stock_account = Account.find_by({'code': :stock})
		if( hub.present?  && warehouse.present? )	
			@result = PostingItem.joins(:project, :commodity).where(account_id: stock_account, hub: hub, warehouse: warehouse).group(:'commodities.id', :'commodities.name', :'project_code').select("projects.project_code as project_code, commodities.id AS commodity_id, commodities.name as commodity, sum(posting_items.quantity) as balance")
		elsif( hub.present? )	
			@result = PostingItem.joins(:project, :commodity).where(account_id: stock_account, hub: hub).group(:'commodities.id', :'commodities.name', :'project_code').select("projects.project_code as project_code, commodities.id AS commodity_id, commodities.name as commodity, sum(posting_items.quantity) as balance")
		else
			@result = PostingItem.joins(:project, :commodity).where(account_id: stock_account).group(:'commodities.id', :'commodities.name', :'project_code').select("projects.project_code as project_code, commodities.id AS commodity_id, commodities.name as commodity, sum(posting_items.quantity) as balance")
		end		
	end

	def dispatch_detail(hub_id, operation_id)

	  filter_map = {}
      if operation_id.present?
				filter_map = {'dispatches.operation_id': operation_id}
			
			if hub_id.present?
				filter_map[:'dispatches.hub_id'] = hub_id
				@hub = Hub.find(hub_id)&.name
			end
	  end

		if filter_map.present?
			@dispatch_items = DispatchItem.joins(:commodity,:project,:unit_of_measure, { dispatch: [ { fdp: [:location] } ,:transporter, :operation] })
            .where(filter_map).select('dispatches.dispatch_date,dispatches.requisition_number,dispatches.operation_id, dispatches.fdp_id as fdp_id,dispatches.gin_no, dispatch_items.dispatch_id, dispatch_items.organization_id, dispatches.transporter_id, dispatches.plate_number, dispatches.trailer_plate_number, dispatch_items.project_id,dispatch_items.commodity_category_id, dispatch_items.commodity_id, dispatch_items.quantity, dispatch_items.unit_of_measure_id,dispatches.storekeeper_name, dispatches.store_id')
		else
				@dispatch_items = []	
		end
		
	end
	

end