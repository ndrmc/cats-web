class AddDocumentTypeToDispatches < ActiveRecord::Migration[5.0]
  def change
    add_column :dispatches, :dispatch_type_id, :integer
    add_column :dispatches, :dispatch_type, :integer
  end
end
