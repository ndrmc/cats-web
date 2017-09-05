class CreateStockSummaryView < ActiveRecord::Migration[5.0]
  def up
  	execute <<-SQL  	
  	   	CREATE VIEW stock_summaries AS
  	   	SELECT 
			pi.id, 
			pi.journal_id, 
			j.name AS journal_name, 
			pi.account_id, 
			a.name AS account_name, 
			pi.hub_id, 
			h.name AS hub_name, 
			pi.warehouse_id, 
			w.name AS warehouse_name, 
			pi.program_id, 
			p.name AS program_name, 
			pi.commodity_id, 
			c.name AS commodity_name, 
			pi.commodity_category_id, 
			cc.name AS commodity_category_name, 
			pi.quantity
		FROM 
			public.posting_items pi
			INNER JOIN public.accounts a on a.id = pi.account_id 
			INNER JOIN public.journals j on j.id = pi.journal_id
			LEFT JOIN public.hubs h on h.id = pi.hub_id 
			LEFT JOIN public.warehouses w on w.id = pi.warehouse_id
			LEFT JOIN public.programs p on p.id = pi.program_id
			INNER JOIN public.commodity_categories cc on cc.id = pi.commodity_category_id
			INNER JOIN public.commodities c on c.id = pi.commodity_id
  	SQL
  end

  def down
  	execute "DROP VIEW stock_summary"
  end
end
