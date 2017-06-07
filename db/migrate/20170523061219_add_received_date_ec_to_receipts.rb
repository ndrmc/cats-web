class AddReceivedDateEcToReceipts < ActiveRecord::Migration[5.0]
  def change
     add_column :receipts, :received_date_ec, :string
  end
end
