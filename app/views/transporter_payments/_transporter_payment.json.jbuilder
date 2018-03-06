json.extract! transporter_payment, :id, :payment_requests_id, :cheque_no, :voucher_no, :bank_name, :paid_amount, :prepared_by, :approved_by, :approved_date, :datetime, :payment_date, :status, :created_at, :updated_at
json.url transporter_payment_url(transporter_payment, format: :json)
