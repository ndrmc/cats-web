class AddCommodityidToRationList < ActiveRecord::Migration[5.0]
  def change
    add_column :ration_items, :commodity_id, :integer    
  end
end
