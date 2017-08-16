class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :name , null: false
      t.integer :code
      t.text :description

      t.timestamps
    end

    add_index :accounts, [:name, :code]
  end
end
