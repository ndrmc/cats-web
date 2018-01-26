class AddReferenceAndRequisitionColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :stock_movements, :reference_no, :string
    add_column :stock_movements, :requisition_no, :string
  end
end
