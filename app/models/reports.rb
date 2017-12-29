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
			@result = StockReportByCommodity.where(:'p_id' => stock_account, :'hub_id' => hub ,:'warehouse_id' => warehouse)
		elsif (hub.present?)
			@result = StockReportByCommodity.where(:'p_id' => stock_account, :'hub_id' => hub)
		else
		  	@result = StockReportByCommodity.where(:'p_id' => stock_account)
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
	
	
end