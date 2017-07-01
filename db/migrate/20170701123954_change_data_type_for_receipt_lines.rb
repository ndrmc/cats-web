class ChangeDataTypeForReceiptLines < ActiveRecord::Migration[5.0]
  def change
       remove_column :receipt_lines , :quantity  
       add_column :receipt_lines , :quantity , :decimal , precision: 15, scale: 2
  end
end
