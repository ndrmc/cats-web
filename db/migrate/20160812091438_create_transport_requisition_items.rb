class CreateTransportRequisitionItems < ActiveRecord::Migration[5.0]
  def change
    create_table :transport_requisition_items do |t|
      t.integer :transport_requisition_item_id
      t.string :requisition_no
      t.integer :fdp_id
      t.integer :commodity_id
      t.decimal :quantity
      t.boolean :has_transport_order
      t.timestamps
    end
  end
end
