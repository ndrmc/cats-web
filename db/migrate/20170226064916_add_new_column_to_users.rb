class AddNewColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_type_id, :integer	  
  end
end
