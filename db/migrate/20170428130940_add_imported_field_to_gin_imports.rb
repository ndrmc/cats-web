class AddImportedFieldToGinImports < ActiveRecord::Migration[5.0]
  def change
    add_column :git_imports, :imported, :boolean
  end
end
