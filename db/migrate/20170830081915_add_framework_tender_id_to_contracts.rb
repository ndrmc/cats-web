class AddFrameworkTenderIdToContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :framework_tender_id, :integer
  end
end
