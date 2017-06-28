require "csv"
require "terminal-table"

namespace :cats do
	namespace :stock do
		desc "Imports sample posting items data from csv file and generate corresponding posting entries."
		task sample_posting_items: :environment do
			posting_items = []
			

			puts "Reading file #{Rails.root}/db/sample-postings.csv to import sample posting data......"

			CSV.foreach("#{Rails.root}/db/sample-postings.csv", :headers => true) do |row|
				journal = Journal.find_by(code: row[0].to_i)
				credit_account = Account.find_by(code: row[1].to_i)
				debit_account = Account.find_by(code: row[2].to_i)
		        credit = PostingItem.new({
											account_id: credit_account.id,
											journal_id: journal.id,
											donor_id: row[3].to_i,
											hub_id: row[4].to_i,
											warehouse_id: row[5].to_i,
											program_id: row[6].to_i,
											commodity_id: row[7].to_i,
											commodity_category_id: row[8].to_i,
											quantity: row[9].to_f,
											operation_id: row[10].to_i,
		        })

		        posting_items << credit

		        debit = PostingItem.new({
											account_id: debit_account.id,
											journal_id: journal.id,
											donor_id: row[3].to_i,
											hub_id: row[4].to_i,
											warehouse_id: row[5].to_i,
											program_id: row[6].to_i,
											commodity_id: row[7].to_i,
											commodity_category_id: row[8].to_i,
											quantity: -row[9].to_f,
											operation_id: row[10].to_i,
											})

		        posting_items << debit

		        posting = Posting.new({
                              document_id: 0,
                              document_type: :stock_take,
                              posting_type: :inventory,
                              posting_items: posting_items
      			})

      			if(posting_items.map { |h| h[:quantity] }.sum != 0)      	
			        raise Exception.new("Posting items did not pass validation.");                
		      	end

		      	posting.save!

		      	puts "Posting result"
				header_table = Terminal::Table.new :title=> journal.name, :headings=> ['Journal', 'Accounts']
				header_rows = []
				header_rows << [journal.name, '']
				header_rows << ['',"#{credit_account.name} : CREDIT" ]
				header_rows << ['',"#{debit_account.name} : DEBIT"]
				header_table.rows = header_rows

				result = []
				posting.posting_items.each do |pi|
				result << [pi.donor_id, pi.hub_id, pi.warehouse_id, pi.program_id, pi.commodity_id, pi.commodity_category_id, pi.quantity ]
				end

				table = Terminal::Table.new :title=> 'Posting Entries', :headings=> ['Donor','Hub', 'Warehouse', 'Program', 'Commodity', 'Commodity category', 'Quantity']
				table.rows = result

				puts header_table
				puts table
		    end
		end
	end
end
