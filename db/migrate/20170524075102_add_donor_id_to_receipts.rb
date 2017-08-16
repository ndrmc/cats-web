class AddDonorIdToReceipts < ActiveRecord::Migration[5.0]
  def change
    add_column :receipts, :donor_id, :integer 
  end
end
