class AddNewColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :Admin, :boolean
	  add_column :users, :IsCaseTeam, :boolean
  end
end
