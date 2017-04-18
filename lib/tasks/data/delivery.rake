require 'csv'

namespace :data do
	namespace :delivery do
		desc 'Import Deliver data found on data/delivery.csv to a temporary table for further processing'
		task import: :environment do
		  puts "Processing Delivery data from CSV"		  
		  rows = 0		  
		  raw_data = File.read('data/delivery.csv', :encoding => 'ISO-8859-1')
		  csv = CSV.parse(raw_data, :headers => true)
		  # TODO
		  # For each row, create a corresponding DeliveryImport object and add it to table
		  # Consider the first row (Header row)		  
		  csv.each do |r|
		  	DeliveryImport.create!(r.to_hash)	
		  	rows += 1
		  end
		  puts "Total number of rows found and imported is #{rows}"

		end

	end
end