class CreateAllocationSummaryView < ActiveRecord::Migration[5.0]
  def up
  	execute <<-SQL
	  	CREATE VIEW allocation_summary AS
	  	select row_number() over () as row_id,
	  		   r.operation_id,
	  		   o.name as operation_name,
	  		   o.program_id,
	  		   r.commodity_id,
	  		   c.name as commodity_name,
	  		   sum(ri.amount) as total_allocation
		from requisitions r
	     inner join requisition_items ri on r.id = ri.requisition_id
	     left join operations o on r.operation_id = o.id
	     left join commodities c on r.commodity_id = c.id
		group by r.operation_id, o.name, o.program_id, r.commodity_id, c.name
		order by row_id, r.operation_id
  	SQL
  end

  def down
  	execute 'DROP VIEW allocation_summary'
  end
end
