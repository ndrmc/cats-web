json.extract! store, :id, :name, :temporary, :hub_id, :store_owner_id, :store_location_id, :created_at, :updated_at
json.url store_url(store, format: :json)