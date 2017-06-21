json.extract! stock_take_item, :id, :commodity_id, :commodity_category_id, :actual_amount, :stock_take_id, :created_at, :updated_at
json.url stock_take_item_url(stock_take_item, format: :json)
