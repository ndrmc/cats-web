class AddReceiveTypeAndReceiveTypeIdToReceipt < ActiveRecord::Migration[5.0]
  def change
    add_column :receipts, :receipt_type, :integer
    add_column :receipts, :receipt_type_id, :integer
  end
end
