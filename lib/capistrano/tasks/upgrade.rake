namespace :upgrade do
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

end
