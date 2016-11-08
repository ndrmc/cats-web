class CreateCommodityCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :commodity_categories do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :code_am
      t.string :description

      t.timestamps
    end

    add_index :commodity_categories, :code, :unique => true

  end
end
