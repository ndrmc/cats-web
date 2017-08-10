namespace :upgrade do

  desc "Update commodity source for automatic project code generation "
  task :populate_comm_source_code do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "cats:receipt:populate_comm_source_code"
        end
      end
    end
  end 

  desc "Upgrade location hierarchies "
  task :location do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "cats:migrate:location"
        end
      end
    end
  end

  desc "Upgrade HRD Items region_id and zone_id attributes"
  task :hrd_items do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "cats:hrd:location"
        end
      end
    end
  end

  desc "Insert starting balance from file found in db/stock-balance.csv"
  task :stock_balance do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "cats:stock:balance"
        end
      end
    end
  end

  desc "Update FDP values"
  task :fdp do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "cats:fdp:update_locations"
        end
      end
    end
  end

end
