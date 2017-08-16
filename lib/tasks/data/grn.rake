namespace :data do
	namespace :grn do
		
		desc 'Import GRN data found on data/receiving.csv to a temporary table for further processing'		
		task import: :environment do
		  puts "Processing Receipt data from CSV"		  
		  rows = 0		  
		  raw_data = File.read('data/receipt.csv', :encoding => 'ISO-8859-1')
		  csv = CSV.parse(raw_data, :headers => true)

		  csv.each do |r|
		  	GrnImport.create!(r.to_hash)	
		  	rows += 1
		  end

		  puts "Total number of rows found and imported is #{rows}"

		end

	end
end