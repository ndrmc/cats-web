namespace :cats do
	namespace :permission do
		desc "Populates fdp_operations_log table with each participating documents"
		task populate_permission_user_type: :environment do

			puts "Start poupulating user_type column of permissions . . ."

            Permission.find_each do |permission|
                i = 1
                puts i.to_s + " iteration"
                while i <= 3
                    new_permission = Permission.new
                    new_permission.name = permission.name
                    new_permission.description = permission.description
                    new_permission.user_type = i
                    new_permission.save!
                    i += 1
                    puts i.to_s + " internal"
                end
				permission.user_type = 0
                permission.save!
			end

			puts "Successfully populated user_type column of permissions."
		end
	end
end