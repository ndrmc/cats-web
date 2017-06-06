class AddArchivedToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :archived, :boolean
  end
end
