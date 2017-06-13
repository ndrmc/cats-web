require "csv"
require "terminal-table"

namespace :cats do
  namespace :stock do
    desc "Imports stock balance count/begining balance from csv file and generate corresponding posting entries."
    task balance: :environment do
      # Source .csv file should have columns with the following order
      # donor_id, hub_id, warehouse_id, program_id, commodity_id, commodity_category_id, quantity
      posting_items = []
      begining_inventory = Journal.find_by(code: :beginning_inventory)

      statistics_account = Account.find_by({'code': :statistics})
      stock_account = Account.find_by({'code': :stock})

      puts "Reading file #{Rails.root}/data/stock-balance.csv to import balance......"

      CSV.foreach("#{Rails.root}/data/stock-balance.csv", :headers => true) do |row|
        credit = PostingItem.new({
                                   account_id: stock_account.id,
                                   journal_id: begining_inventory.id,
                                   donor_id: row[0].to_i,
                                   hub_id: row[1].to_i,
                                   warehouse_id: row[2].to_i,
                                   program_id: row[3].to_i,
                                   commodity_id: row[4].to_i,
                                   commodity_category_id: row[5].to_i,
                                   quantity: row[6].to_f
        })

        posting_items << credit

        debit = PostingItem.new({
                                  account_id: statistics_account.id,
                                  journal_id: begining_inventory.id,
                                  donor_id: row[0].to_i,
                                  hub_id: row[1].to_i,
                                  warehouse_id: row[2].to_i,
                                  program_id: row[3].to_i,
                                  commodity_id: row[4].to_i,
                                  commodity_category_id: row[5].to_i,
                                  quantity: -row[6].to_f
        })

        posting_items << debit
      end

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
      header_table = Terminal::Table.new :title=> 'Begining Inventory', :headings=> ['Journal', 'Accounts']
      header_rows = []
      header_rows << [begining_inventory.name, '']
      header_rows << ['',"#{stock_account.name} : CREDIT" ]
      header_rows << ['',"#{statistics_account.name} : DEBIT"]
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
