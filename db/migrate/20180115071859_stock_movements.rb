class StockMovements < ActiveRecord::Migration[5.0]
  def change
    add_column :stock_movements, :status, :integer
  end
end
