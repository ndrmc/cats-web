class DropLocationTypesTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :location_types
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
