json.extract! delivery, :id, :receiving_number, :donor_id, :transporter_id, :primary_plate_number, :trailer_plate_number, :driver_name, :fdp_id, :dispatch_id, :waybill_number, :requisition_number, :hub_id, :invoice_number, :delivery_by, :delivery_date, :received_by, :received_date, :document_received_by, :document_received_date, :status, :action_type, :action_type_remark, :posting_id, :operation_id, :created_at, :updated_at
json.url delivery_url(delivery, format: :json)