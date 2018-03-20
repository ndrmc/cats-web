class AddTransportOrderIdToPaymentRequestItem < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_request_items, :transport_order_id, :integer
  end
end
