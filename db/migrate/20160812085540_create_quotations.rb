class CreateQuotations < ActiveRecord::Migration[5.0]
  def change
    create_table :quotations do |t|
      t.integer :bid_submission_id
      t.integer :store_id
      t.integer :destination_id
      t.decimal :tariff_quote
      t.text :remark

      t.timestamps
    end
  end
end
