class AddRelifAndPsnpAmountsToBid < ActiveRecord::Migration[5.0]
  def change
     add_column :bids, :relif_amount_in_quintal, :decimal
     add_column :bids, :psnp_amount_in_quintal, :decimal
  end
end
