class CreateCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :currencies do |t|
      t.string :name, null: false
      t.string :symbol
      t.text :description
      t.timestamps
    end

    add_index :currencies, :name , :unique => true
  end
end
