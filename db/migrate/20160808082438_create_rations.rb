class CreateRations < ActiveRecord::Migration[5.0]
  def change
    create_table :rations do |t|
      t.string :reference_no , null: false
      t.string :description
      t.boolean :current
      t.timestamps
    end
    add_index :rations, :reference_no, :unique => true
  end
end
