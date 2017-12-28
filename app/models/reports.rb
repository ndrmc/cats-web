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
			 @result = PostingItem.joins(:hub, :warehouse,:account, :commodity, :commodity_category).
					select('hubs.name as hub,hubs.id as hub_id,warehouses.name as warehouse, warehouses.id as warehouse_id,commodity_categories.id as commodity_category_id, commodities.id as commodity_id, commodities.name as commodity, sum(quantity) as balance').
					group('commodity_categories.id,hubs.id, hubs.name,warehouses.id,warehouses.name,commodities.id, commodities.name').
					where(:'account_id' => stock_account, :'hubs.id' => hub,:'warehouses.id' => warehouse)
			@result = @result.group_by {| stock| stock.commodity_category.id }
		elsif (hub.present?)
			@result = PostingItem.joins(:hub, :warehouse,:account, :commodity, :commodity_category).
					select('hubs.name as hub,hubs.id as hub_id,warehouses.name as warehouse, warehouses.id as warehouse_id,commodity_categories.id as commodity_category_id, commodities.id as commodity_id, commodities.name as commodity, sum(quantity) as balance').
					group('commodity_categories.id,hubs.id, hubs.name,warehouses.id,warehouses.name,commodities.id, commodities.name').
					where(:'account_id' => stock_account, :'hubs.id' => hub)
			@result = @result.group_by {| stock| stock.commodity_category.id }
			
		else
		  	@result = PostingItem.joins(:hub, :warehouse,:account, :commodity, :commodity_category).
			select('hubs.name as hub,hubs.id as hub_id,warehouses.name as warehouse, warehouses.id as warehouse_id,commodity_categories.id as commodity_category_id, commodities.id as commodity_id, commodities.name as commodity, sum(quantity) as balance').
			group('commodity_categories.id,hubs.id, hubs.name,warehouses.id,warehouses.name,commodities.id, commodities.name').
			where(:'account_id' => stock_account)
			@result = @result.group_by {| stock| stock.commodity_category.id }
		end
	end
	
end