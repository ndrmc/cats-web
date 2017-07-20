class ChangeDispatchDetailQuanityDataTypeToDecimal < ActiveRecord::Migration[5.0]
  def change
     def self.up
      change_table :dispatch_items do |t| 
      t.change :quantity, :decimal, precision:15, scale: 3
      end
  end
   
  def self.down
      change_table :dispatch_items do|t|
      t.change :quantity, :integer
  end
end

  end
end
