class CreatePostingItems < ActiveRecord::Migration[5.0]
  def change
    create_table :posting_items do |t|     
     
      t.uuid :posting_item_code
      t.integer :posting_id
      t.integer :account_id
      t.integer :journal_id
      t.integer :donor_id

      t.integer :hub_id
      t.integer :warehouse_id
      t.integer :store_id
      t.integer :stack_id

      t.integer :project_id
      t.integer :batch_id
      t.integer :program_id
      t.integer :operation_id

      t.integer :commodity_id
      t.integer :commodityCategory_id

      t.decimal :quantity

      t.integer :region_id
      t.integer :zone_id
      t.integer :woreda_id
      t.integer :fdp_id
    
      t.integer :created_by
      t.integer :modified_by
      t.boolean :deleted, :default => false
      t.datetime :deleted_at

      t.timestamps 

    end
  end
end
