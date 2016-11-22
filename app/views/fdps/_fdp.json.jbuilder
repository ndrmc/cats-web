json.extract! fdp, :id, :name, :description, :lat, :lon, :active, :created_at, :updated_at
json.url fdp_url(fdp, format: :json)