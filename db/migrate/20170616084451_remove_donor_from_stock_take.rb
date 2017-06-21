class RemoveDonorFromStockTake < ActiveRecord::Migration[5.0]
  def change
     remove_column :stock_takes, :donor_id
     add_column :stock_takes, :title, :string, null: false
  end
end
