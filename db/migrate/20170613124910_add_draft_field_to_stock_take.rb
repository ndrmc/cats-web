class AddDraftFieldToStockTake < ActiveRecord::Migration[5.0]
  def change
     add_column :stock_takes, :draft, :boolean, default: true
  end
end
