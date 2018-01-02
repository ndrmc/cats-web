class CreateDispatchByProjectReportView < ActiveRecord::Migration[5.0]
  def up
  	execute <<-SQL  
        CREATE VIEW dispatch_report_by_projects AS	
        select pi.account_id,pi.journal_id,pi.id,di.dispatch_date,h.id as hub_id, w.id as warehouse_id, h.name as hub, w.name as warehouse, p.project_code,c.name as commodity, sum(pi.quantity) as balance 
			  FROM posting_items pi 
				inner join commodities c on pi.commodity_id = c.id
				inner join projects p on pi.project_id = p.id
				inner join hubs h on pi.hub_id = h.id
				inner join warehouses w on pi.warehouse_id = w.id
				inner join postings po on pi.posting_id = po.id
				inner join dispatches di on po.document_id = di.id
				group by pi.account_id,pi.journal_id,pi.id,p.project_code,c.name,h.name, h.id,w.id, w.name, di.dispatch_date
  	SQL
  end

  def down
  	execute "DROP VIEW dispatch_report_by_projects"
  end
end
