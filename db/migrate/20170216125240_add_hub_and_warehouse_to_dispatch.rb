class AddHubAndWarehouseToDispatch < ActiveRecord::Migration[5.0]
  def change
    add_reference :dispatches, :hub, foreign_key: true
    add_reference :dispatches, :warehouse, foreign_key: true
  end
end
