class ChangeDataTypeQuantityForReceiptLines < ActiveRecord::Migration[5.0]
  def change
       change_column :receipt_lines ,:quantity ,:decimal , precision: 15, scale: 2
  end
end
