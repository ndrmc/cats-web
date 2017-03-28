class AddDepartmentToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :department, :integer
  end
end
