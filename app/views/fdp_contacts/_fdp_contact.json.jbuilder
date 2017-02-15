json.extract! fdp_contact, :id, :name, :description, :lat, :lon, :active, :location_id, :created_at, :updated_at
json.url fdp_contact_url(fdp_contact, format: :json)