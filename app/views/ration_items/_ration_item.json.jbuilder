json.extract! ration_item, :id, :amount, :ration_id, :unit_of_measure_id, :commodity_id, :created_at, :updated_at
json.url ration_item_url(ration_item, format: :json)