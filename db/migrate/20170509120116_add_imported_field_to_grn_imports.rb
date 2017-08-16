class AddImportedFieldToGrnImports < ActiveRecord::Migration[5.0]
  def change
    add_column :grn_imports, :imported, :boolean
  end
end
