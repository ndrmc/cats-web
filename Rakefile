# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

Rake::Task["db:migrate"].enhance do
	if (ENV['RAILS_ENV'] == "test")
		if ActiveRecord::Base.schema_format == :sql
			Rake::Task["db:schema:dump"].invoke
			Rake::Task["db:migrate"].invoke
		end
	end	
end

Rake::Task["db:rollback"].enhance do
	if (ENV['RAILS_ENV'] == "test")
		if ActiveRecord::Base.schema_format == :sql
			Rake::Task["db:schema:dump"].invoke
			Rake::Task["db:migrate"].invoke
		end
	end
end