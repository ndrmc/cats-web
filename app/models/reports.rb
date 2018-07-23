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
			.exec_query('select projects.project_code as project_code, commodity_sources.name as commodity_source, hubs.name as hub, warehouses.name as warehouse, commodities.name as commodity, sum(posting_items.quantity) as balance
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

	def stock_status_by_store hub, warehouse, as_of_date
		stock_account = Account.find_by({'code': :stock}).id
		dispatched_account = Account.find_by({'code': :dispatched}).id
		receipt_journal = Journal.find_by({'code': :goods_received}).id
		good_issue_journal = Journal.find_by({'code': :goods_issue}).id

		result = ActiveRecord::Base.connection
		.exec_query("SELECT coalesce(prev.store, curr.store) store,
		coalesce(prev.project_code, curr.project_code) project_code,
		coalesce(prev.commodity_source, curr.commodity_source) commodity_source,
		coalesce(prev.hub, curr.hub) hub,
		coalesce(prev.warehouse, curr.warehouse) warehouse,
		coalesce(prev.commodity_category, curr.commodity_category) commodity_category,
		coalesce(prev.commodity, curr.commodity) commodity, 
		prev.prev_balance, rece.receipt_balance, disp.dispatch_balance, curr.current_balance
		FROM 
		(SELECT pi.store_id, s.name AS store, pi.project_id, p.project_code AS project_code, 
			 cs.name AS commodity_source, 
			 pi.hub_id, h.name AS hub, 
			pi.warehouse_id, w.name AS warehouse, 
			 cc.name AS commodity_category, 
			 pi.commodity_id, c.name AS commodity, SUM(pi.quantity) AS prev_balance
			FROM posting_items pi
			 LEFT JOIN stores s ON s.id = pi.store_id
			LEFT JOIN projects p ON p.id = pi.project_id
			LEFT JOIN commodity_sources cs ON cs.id = p.commodity_source_id
			LEFT JOIN commodities c ON c.id = pi.commodity_id
			 LEFT JOIN commodity_categories cc ON cc.id = c.commodity_category_id 
			LEFT JOIN hubs h ON h.id = pi.hub_id
			LEFT JOIN warehouses w ON w.id = pi.warehouse_id
			WHERE pi.account_id = #{stock_account}
			AND pi.hub_id = #{hub}
			AND pi.warehouse_id = #{warehouse}
			 AND pi.created_at < '#{as_of_date}'
			GROUP BY pi.store_id, pi.project_id, pi.hub_id, pi.warehouse_id, pi.commodity_id, store, 
				 commodity_source, hub, warehouse, commodity, project_code, commodity_category) prev
		FULL OUTER JOIN
		(SELECT pi.store_id, pi.project_id, pi.hub_id, pi.warehouse_id, pi.commodity_id,
			SUM(pi.quantity) AS receipt_balance
			FROM posting_items pi
			 INNER JOIN postings po ON po.id = pi.posting_id
			 INNER JOIN receipts ON receipts.id = po.document_id
			 WHERE pi.account_id = #{stock_account}
			 AND pi.journal_id = #{receipt_journal}
			AND pi.hub_id = #{hub}
			AND pi.warehouse_id = #{warehouse}
			 AND receipts.received_date > '#{as_of_date}'
			GROUP BY pi.store_id, pi.project_id, pi.hub_id, pi.warehouse_id, pi.commodity_id) rece
		ON prev.project_id = rece.project_id AND prev.hub_id = rece.hub_id AND prev.warehouse_id = rece.warehouse_id
		AND prev.commodity_id = rece.commodity_id
		FULL OUTER JOIN
		(SELECT pi.store_id, pi.project_id, pi.hub_id, pi.warehouse_id, pi.commodity_id,
			SUM(pi.quantity) AS dispatch_balance
			FROM posting_items pi
			 INNER JOIN postings po ON po.id = pi.posting_id
			 INNER JOIN dispatches ON dispatches.id = po.document_id
			 WHERE pi.account_id = #{dispatched_account}
			 AND pi.journal_id = #{good_issue_journal}
			AND pi.hub_id = #{hub}
			AND pi.warehouse_id = #{warehouse}
			 AND dispatches.dispatch_date > '#{as_of_date}'
			GROUP BY pi.store_id, pi.project_id, pi.hub_id, pi.warehouse_id, pi.commodity_id) disp
		ON prev.project_id = disp.project_id AND prev.hub_id = disp.hub_id AND prev.warehouse_id = disp.warehouse_id
		AND prev.commodity_id = disp.commodity_id
		FULL OUTER JOIN
		(SELECT pi.store_id, s.name AS store, pi.project_id, p.project_code AS project_code, 
			 cs.name AS commodity_source, 
			 pi.hub_id, h.name AS hub, 
			pi.warehouse_id, w.name AS warehouse, 
			 cc.name AS commodity_category, 
			 pi.commodity_id, c.name AS commodity, SUM(pi.quantity) AS current_balance
			FROM posting_items pi
			 LEFT JOIN stores s ON s.id = pi.store_id
			LEFT JOIN projects p ON p.id = pi.project_id
			LEFT JOIN commodity_sources cs ON cs.id = p.commodity_source_id
			LEFT JOIN commodities c ON c.id = pi.commodity_id
			 LEFT JOIN commodity_categories cc ON cc.id = c.commodity_category_id 
			LEFT JOIN hubs h ON h.id = pi.hub_id
			LEFT JOIN warehouses w ON w.id = pi.warehouse_id
			WHERE pi.account_id = #{stock_account}
			AND pi.hub_id = #{hub}
			AND pi.warehouse_id = #{warehouse}
			GROUP BY pi.store_id, pi.project_id, pi.hub_id, pi.warehouse_id, pi.commodity_id, store, 
				 commodity_source, hub, warehouse, commodity, project_code, commodity_category) curr
		ON prev.project_id = curr.project_id AND prev.hub_id = curr.hub_id AND prev.warehouse_id = curr.warehouse_id
		AND prev.commodity_id = curr.commodity_id")

			
	end	

end