class CreateFscdAnnualPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :fscd_annual_plans do |t|
      t.string :name, null: false
      t.string :code
      t.string :year
      t.integer :duration
      t.integer :status, default: 0, null: false
      t.boolean :archive
      t.integer :ration_id

      t.timestamps
    end

    add_index :fscd_annual_plans, :year, :unique => true
  end
end
