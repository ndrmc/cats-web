class AddColumnsToTransportRequisition < ActiveRecord::Migration[5.0]
  def change
    add_column :transport_requisitions, :reference_number, :string
    add_column :transport_requisitions, :certified_by, :integer
    add_column :transport_requisitions, :certified_date, :string
    add_column :transport_requisitions, :status, :integer
  end
end
