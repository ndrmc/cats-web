class AddUnitOfMeasureIdToPaymentRequestItems < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_request_items, :unit_of_measure_id, :integer
  end
end
