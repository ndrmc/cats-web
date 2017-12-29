class StockReportByCommodities < ActiveRecord::Migration[5.0]
  def up
  	execute <<-SQL  
        CREATE VIEW stock_report_by_commodities AS	
  	    SELECT h.name AS hub,
              w.name AS warehouse,
              cc.name AS commodity_category,
              c.name AS commodity,
              sum(pi.quantity) AS balance,
              pi.account_id AS p_id,
              h.id AS hub_id,
              w.id AS warehouse_id
   FROM posting_items pi
            JOIN hubs h ON pi.hub_id = h.id
            JOIN warehouses w ON pi.warehouse_id = w.id
            JOIN accounts a ON pi.account_id = a.id
            JOIN commodities c ON pi.commodity_id = c.id
            JOIN commodity_categories cc ON pi.commodity_category_id = cc.id
  GROUP BY h.name, w.name, cc.name, c.name, pi.account_id, h.id, w.id
  	SQL
  end

  def down
  	execute "DROP VIEW stock_report_by_commodities"
  end
end
