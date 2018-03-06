json.extract! transporter_payment, :id, :payment_requests_id, :chequeNo, :voucherNo, :bankName, :paidAmount, :paymentDate, :status, :created_at, :updated_at
json.url transporter_payment_url(transporter_payment, format: :json)
