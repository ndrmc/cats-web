json.extract! stock_movement, :id, :source_hub_id, :source_warehouse_id, :source_store_id, :destination_hub_id, :destination_warehouse_id, :destination_store_id, :project_id, :commodity_id, :quantity, :quantity, :description, :created_at, :updated_at
json.url stock_movement_url(stock_movement, format: :json)
