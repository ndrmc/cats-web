class CreateFundTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :fund_types do |t|
      t.string :name, null: false
      t.text :description
      t.timestamps
    end

    add_index :fund_types, :name, :unique => true
  end
end
