class AddColumnsToContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :bid_id, :integer
    add_column :contracts, :signed, :boolean
    add_column :contracts, :last_printed_at, :datetime
    add_column :contracts, :printed_copies, :integer
  end
end
