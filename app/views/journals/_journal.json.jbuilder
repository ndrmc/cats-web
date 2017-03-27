json.extract! journal, :id, :name, :description, :code, :created_at, :updated_at
json.url journal_url(journal, format: :json)
