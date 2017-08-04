namespace :cats do
	namespace :receipt do
		desc "Populates fdp_operations_log table with each participating documents"
		task populate_comm_source_code: :environment do

			puts "Start poupulating code column of commodity_sources . . ."

			CommoditySource.find_each do |commodity_source|
				if(commodity_source.name == "Donation")
					commodity_source.code = "DN"
					commodity_source.save
				end
				if(commodity_source.name == "Loan")
					commodity_source.code = "LN"
					commodity_source.save
				end
				if(commodity_source.name == "Local Purchase")
					commodity_source.code = "LP"
					commodity_source.save
				end
				if(commodity_source.name == "Transfer")
					commodity_source.code = "TR"
					commodity_source.save
				end
				if(commodity_source.name == "Others")
					commodity_source.code = "OT"
					commodity_source.save
				end
				if(commodity_source.name == "Swap")
					commodity_source.code = "SP"
					commodity_source.save
				end
				if(commodity_source.name == "Return")
					commodity_source.code = "RT"
					commodity_source.save
				end
				if(commodity_source.name == "Repayment")
					commodity_source.code = "RP"
					commodity_source.save
				end
			end

			inter_purchase = CommoditySource.where(:name => "International Purchase").first
			if(inter_purchase.blank?)
				inter_pur_source = CommoditySource.new
				inter_pur_source.name = "International Purchase"
				inter_pur_source.code = "IP"
				inter_pur_source.save
			end

			puts "Successfully populated code column of commodit_sources."
		end
	end
end