class AddArchiveFieldToOperation < ActiveRecord::Migration[5.0]
  def change
    add_column :operations, :archived, :boolean
  end
end
