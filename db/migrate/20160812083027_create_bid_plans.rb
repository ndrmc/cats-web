class CreateBidPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :bid_plans do |t|
      t.string :year, null: false
      t.integer :half_year
      t.integer :program_id
      t.string :code
      t.text :description
      t.timestamps
    end
  end
end
