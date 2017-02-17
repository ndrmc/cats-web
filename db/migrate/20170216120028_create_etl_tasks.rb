class CreateEtlTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :etl_tasks do |t|
      t.string :name, null: false
      t.boolean :executed
      t.datetime :executed_at
      t.text :description

      t.integer :created_by
      t.integer :modified_by
      t.boolean :deleted, :default => false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
