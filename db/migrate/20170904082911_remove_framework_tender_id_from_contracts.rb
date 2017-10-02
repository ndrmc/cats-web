class RemoveFrameworkTenderIdFromContracts < ActiveRecord::Migration[5.0]
  def change
    remove_column :contracts, :framework_tender_id, :integer
  end
end
