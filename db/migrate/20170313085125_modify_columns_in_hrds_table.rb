class ModifyColumnsInHrdsTable < ActiveRecord::Migration[5.0]

  def change 
    remove_column :hrds, :month_to, :integer
    remove_column :hrds, :current, :boolean
    remove_column :hrds, :archived, :boolean
    
    rename_column :hrds, :year, :year_gc 
    add_column :hrds, :year_ec, :integer  
  end
  
end
