class CreateRequisitionItems < ActiveRecord::Migration[5.0]
  def change
    create_table :requisition_items do |t|
      t.integer :requisition_id
      t.integer :commodity_id
      t.integer :unit_of_measure_id
      t.integer :fdp_id
      t.integer :beneficiary_no, null: false
      t.decimal :amount, null: false
      t.decimal :contingency
      t.timestamps
    end
  end
end
