class AddDonorAndProjectToStockTakeItem < ActiveRecord::Migration[5.0]
  def change   
     add_column :stock_take_items, :donor_id, :integer, null: false
     add_column :stock_take_items, :project_id, :integer
  end
end
