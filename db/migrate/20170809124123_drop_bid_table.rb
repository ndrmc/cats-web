class DropBidTable < ActiveRecord::Migration[5.0]
  def up
      drop_table :bids
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
  
end
