class StockStatusController < ApplicationController
  
  def index
  	if( params[:hub].present? && params[:program].present? && params[:commodity].present? )
  		@result = ActiveRecord::Base.connection
		.exec_query('SELECT hubs.name AS hub, commodities.name AS commodity, donors.name AS donor, programs.name AS program, 
			EPI.expected, RPI.received, DiPI.dispatched, DePI.delivered, (DiPI.dispatched - DePI.delivered)  AS git
		FROM
		(Select hub_id, program_id, commodity_id, donor_id, ABS(SUM(quantity)) AS expected from posting_items 
			WHERE (journal_id = 2 OR journal_id = 4 OR journal_id = 7) AND account_id = 1
			AND hub_id = ' + params[:hub] + 
			' AND program_id = ' + params[:program] + ' AND commodity_id = ' + params[:commodity] + '
			GROUP BY hub_id, program_id, commodity_id, donor_id) EPI		
		LEFT JOIN	
			(Select hub_id, program_id, commodity_id, donor_id, SUM(quantity) AS received from posting_items 
			WHERE journal_id = 3 AND account_id = 7 AND hub_id = ' + params[:hub] + 
			' AND program_id = ' + params[:program] + ' AND commodity_id = ' + params[:commodity] + '
			GROUP BY hub_id, program_id, commodity_id, donor_id) RPI
				ON RPI.hub_id = EPI.hub_id AND RPI.program_id = EPI.program_id AND RPI.commodity_id = EPI.commodity_id
						AND RPI.donor_id = EPI.donor_ID
		LEFT JOIN
			(Select hub_id, program_id, commodity_id, donor_id, SUM(quantity) AS dispatched from posting_items 
			WHERE journal_id = 6 AND account_id = 4 AND hub_id = ' + params[:hub] + 
			' AND program_id = ' + params[:program] + ' AND commodity_id = ' + params[:commodity] + ' 
			GROUP BY hub_id, program_id, commodity_id, donor_id) DiPI
				ON DiPI.hub_id = EPI.hub_id AND DiPI.program_id = EPI.program_id AND DiPI.commodity_id = EPI.commodity_id
					AND DiPI.donor_id = EPI.donor_ID	
		LEFT JOIN
			(Select hub_id, program_id, commodity_id, donor_id, ABS(SUM(quantity)) AS delivered from posting_items 
			WHERE journal_id = 11 AND account_id = 5 AND hub_id = ' + params[:hub] + 
			' AND program_id = ' + params[:program] + ' AND commodity_id = ' + params[:commodity] + ' 
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
				WHERE (journal_id = 2 OR journal_id = 4 OR journal_id = 7) AND account_id = 1 
				GROUP BY hub_id, program_id, commodity_id, donor_id) EPI		
			LEFT JOIN	
				(Select hub_id, program_id, commodity_id, donor_id, SUM(quantity) AS received from posting_items 
				WHERE journal_id = 3 AND account_id = 7 
				GROUP BY hub_id, program_id, commodity_id, donor_id) RPI
					ON RPI.hub_id = EPI.hub_id AND RPI.program_id = EPI.program_id AND RPI.commodity_id = EPI.commodity_id
							AND RPI.donor_id = EPI.donor_ID
			LEFT JOIN
				(Select hub_id, program_id, commodity_id, donor_id, SUM(quantity) AS dispatched from posting_items 
				WHERE journal_id = 6 AND account_id = 4 
				GROUP BY hub_id, program_id, commodity_id, donor_id) DiPI
					ON DiPI.hub_id = EPI.hub_id AND DiPI.program_id = EPI.program_id AND DiPI.commodity_id = EPI.commodity_id
						AND DiPI.donor_id = EPI.donor_ID	
			LEFT JOIN
				(Select hub_id, program_id, commodity_id, donor_id, ABS(SUM(quantity)) AS delivered from posting_items 
				WHERE journal_id = 11 AND account_id = 5 
				GROUP BY hub_id, program_id, commodity_id, donor_id) DePI
					ON DePI.hub_id = EPI.hub_id AND DePI.program_id = EPI.program_id AND DePI.commodity_id = EPI.commodity_id
						AND DePI.donor_id = EPI.donor_ID
			LEFT JOIN hubs on hubs.id = EPI.hub_id
			LEFT JOIN programs on programs.id =EPI.program_id	
			LEFT JOIN commodities on commodities.id =EPI.commodity_id	
			LEFT JOIN donors on donors.id =EPI.donor_id')
	end
	@stock_status = @result
  end

end
