class AddColumnToDeliveryDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :delivery_details, :market_price, :decimal
  end
end
