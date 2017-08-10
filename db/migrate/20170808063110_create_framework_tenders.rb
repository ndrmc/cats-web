class CreateFrameworkTenders < ActiveRecord::Migration[5.0]
  def change
    create_table :framework_tenders do |t|
      t.integer :year
      t.integer :half_year
      t.integer :starting_month
      t.integer :ending_month
      t.integer :status
      t.text :remark
      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
