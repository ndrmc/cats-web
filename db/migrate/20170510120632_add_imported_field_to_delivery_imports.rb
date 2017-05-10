class AddImportedFieldToDeliveryImports < ActiveRecord::Migration[5.0]
  def change
    add_column :delivery_imports, :imported, :boolean
  end
end
