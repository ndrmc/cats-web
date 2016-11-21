class AddCreatedByAndModifiedByAndDeletedToAccount < ActiveRecord::Migration[5.0]
  def change
	add_column :accounts, :created_by, :integer
	add_column :accounts, :modified_by, :integer	
  end
end
