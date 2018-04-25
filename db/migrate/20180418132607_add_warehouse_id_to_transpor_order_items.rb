class AddWarehouseIdToTransporOrderItems < ActiveRecord::Migration[5.0]
  def change
    add_column :transport_order_items, :warehouse_id, :integer
  end
end
  