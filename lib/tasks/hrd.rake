namespace :cats do
	namespace :hrd do
		desc "Migrates hrd records location hierarchy"
		task location: :environment do
			# Update region_id and zone_id fields for HRD items
			updated = 0

			HrdItem.all.each do |i|
				node = Location.find(i.woreda_id)
				i.region_id = node.ancestors.where(location_type: :region)
				i.zone_id = node.ancestors.where(location_type: :zone)
				i.save
				updated += 1
			end

			puts "Updated #{updated} HRD Item records."
		end
	end
end

