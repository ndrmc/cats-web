class CreateTransporters < ActiveRecord::Migration[5.0]
  def change
    create_table :transporters do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :ownership
      t.integer :vehicle_count
      t.decimal :lift_capacity
      t.decimal :capital
      t.integer :employees
      t.string :contact
      t.string :contact_phone
      t.text :remark
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
