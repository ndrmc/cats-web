json.extract! account, :id, :name, :type, :description, :created_at, :updated_at
json.url account_url(account, format: :json)