class AddRationToOperation < ActiveRecord::Migration[5.0]
  def change
  	add_column :operations, :ration_id, :integer
	
  end
end
