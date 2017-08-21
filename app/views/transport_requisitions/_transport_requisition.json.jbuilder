json.extract! transport_requisition, :id, :reference_number, :location_id, :operation_id, :certified_by, :certified_date, :description, :status, :deleted_at, :created_at, :updated_at
json.url transport_requisition_url(transport_requisition, format: :json)
