class AddRelifAndPsnpAmountsToBid < ActiveRecord::Migration[5.0]
  def change
     add_column :bids, :RelifAmountInQuintal, :decimal
     add_column :bids, :PSNPAmountInQuintal, :decimal
  end
end
