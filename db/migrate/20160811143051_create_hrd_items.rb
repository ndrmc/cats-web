class CreateHrdItems < ActiveRecord::Migration[5.0]
  def change
    create_table :hrd_items do |t|
      t.integer :hrd_id
      t.integer :woreda_id
      t.integer :duration
      t.integer :starting_month
      t.integer :beneficiary 
      t.timestamps
    end
  end
end
