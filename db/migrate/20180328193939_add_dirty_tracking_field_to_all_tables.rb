class AddDirtyTrackingFieldToAllTables < ActiveRecord::Migration[5.0]
  def change
    tables = ActiveRecord::Base.connection.tables - ["schema_migrations"]
    tables.each do |table|
      add_column table, :is_dirty, :boolean, null: false, :default => true
    end
  end
end
