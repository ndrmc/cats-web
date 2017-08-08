class CreateFrameworkTenders < ActiveRecord::Migration[5.0]
  def change
    create_table :framework_tenders do |t|
      t.integer :year
      t.integer :half_year
      t.integer :starting_month
      t.integer :ending_month
      t.interger :status
      t.text :remark

      t.timestamps
    end
  end
end
