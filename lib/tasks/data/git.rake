namespace :data do
	namespace :git do
		desc 'Import Issue Ticket data found on data/receiving.csv to a temporary table for further processing'
		task import: :environment do
		  puts "Processing Dispatch data from CSV"		  
		  rows = 0		  
		  raw_data = File.read('data/dispatch.csv', :encoding => 'ISO-8859-1')
		  csv = CSV.parse(raw_data, :headers => true)

		  csv.each do |r|
		  	GitImport.create!(r.to_hash)	
		  	rows += 1
		  end

		  puts "Total number of rows found and imported is #{rows}"

		end

	end
end