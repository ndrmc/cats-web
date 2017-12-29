namespace :cats do
	namespace :permission do
		desc "Add new permission entity to permission table"
		task permission_items: :environment do
			Permission.create({:name => 'Transporters'})
			Permission.create({:name => 'StockTake'})
			puts "Added new permission items to the database."
		end
	end
end
