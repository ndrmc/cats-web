namespace :cats do
	namespace :psnp do
		desc "updates psnp location hierarchy based on ancestry gem path-enumeration pattern"
		task location: :environment do
			# Update region_id and zone_id fields for HRD items
			updated = 0

			PsnpPlanItem.all.each do |i|
				node = Location.find(i.woreda_id)
				i.region_id = node.ancestors.where(location_type: :region)
				i.zone_id = node.ancestors.where(location_type: :zone)
				i.save
				updated += 1
			end

			puts "Updated #{updated} PSNP Plan Item records."
		end
	end
end

