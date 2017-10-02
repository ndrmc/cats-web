class DropBidTable < ActiveRecord::Migration[5.0]
  def change
      drop_table :bids do |bid|
          bid.string :bid_no
          bid.timestamps
      end
      
  end 
end
