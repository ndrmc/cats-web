class ChangeDataTypeQuantityForReceiptLines < ActiveRecord::Migration[5.0]
 
  def self.up
    change_table :receipt_lines do |t| 
      t.change :quantity, :decimal, precision:15, scale: 2
      end
  end
   
  def self.down
    change_table :receipt_lines do|t|
      t.change :quantity, :integer
  end
end

end
