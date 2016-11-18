class AddNewColumnToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :deleted, :boolean, :default => false
  end
end
