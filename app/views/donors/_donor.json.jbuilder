json.extract! donor, :id, :name, :code, :responsible, :source, :description, :created_at, :updated_at
json.url donor_url(donor, format: :json)