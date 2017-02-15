class CreatePostings < ActiveRecord::Migration[5.0]
  def change
    create_table :postings do |t|     
     
      t.uuid :posting_code
      t.integer :document_type
      t.integer :document_id     
      t.boolean :posted
      t.integer :reversed_posting_id
      t.integer :posting_type
    
      t.integer :created_by
      t.integer :modified_by
      t.boolean :deleted, :default => false
      t.datetime :deleted_at

      t.timestamps 

    end
  end
end
