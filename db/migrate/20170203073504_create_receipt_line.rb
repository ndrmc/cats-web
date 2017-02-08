class CreateReceiptLine < ActiveRecord::Migration[5.0]
  def change
    create_table :receipt_lines do |t|
      t.references :receipt

      t.references :commodity_category 
      t.references :commodity 
      t.decimal :quantity 

      t.references :project 

      t.integer :created_by
      t.integer :modified_by
      t.boolean :deleted, :default => false
      t.datetime :deleted_at

      t.timestamps 
    end
  end
end
