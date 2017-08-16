json.extract! stock_take, :id, :hub_id, :warehouse_id, :store_no, :date, :created_at, :updated_at
json.url stock_take_url(stock_take, format: :json)
