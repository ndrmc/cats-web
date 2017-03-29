class AddRequestIdToRequisition < ActiveRecord::Migration[5.0]
  def change
  	add_column :requisitions, :request_id, :integer, null: false
	
  end
end
