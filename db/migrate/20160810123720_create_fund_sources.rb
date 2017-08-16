class CreateFundSources < ActiveRecord::Migration[5.0]
  def change
    create_table :fund_sources do |t|
      t.string :name, null: false
      t.text :description
      t.timestamps
    end

    add_index :fund_sources, :name, :unique => true
  end
end
