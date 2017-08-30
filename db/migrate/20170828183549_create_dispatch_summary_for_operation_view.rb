class CreateDispatchSummaryForOperationView < ActiveRecord::Migration[5.0]
  def up
  	execute <<-SQL
  		CREATE VIEW dispatch_summaries AS
      select row_number() over () as row_id, o.id as operation_id,o.year as operation_year, o.name as operation_name, sum(quantity)
      from posting_items pi
           inner join operations o on pi.operation_id = o.id
      where pi.journal_id = 6 and account_id = 4
      group by o.id, o.year, o.name
      order by o.id
  	SQL
  end

  def down
  	execute 'DROP VIEW dispatch_summaries'
  end
end
