json.extract! gift_certificate, :id, :reference_no, :gift_date, :vessel, :donor_id, :eta, :program_id, :mode_of_transport_id, :port_name, :status, :customs_declaration_no, :bill_of_loading, :amount, :estimated_price, :estimated_tax, :expiry_date, :created_at, :updated_at
json.url gift_certificate_url(gift_certificate, format: :json)
