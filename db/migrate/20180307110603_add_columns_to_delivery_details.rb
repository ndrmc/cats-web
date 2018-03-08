class AddColumnsToDeliveryDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :delivery_details, :loss_quantity, :decimal
    add_column :delivery_details, :loss_reason, :string
  end
end
