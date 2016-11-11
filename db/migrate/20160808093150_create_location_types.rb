class CreateLocationTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :location_types do |t|
      t.string :name, null: false
      t.string :description

      t.timestamps
    end

    add_index :location_types, :name, :unique => true
  end
end
