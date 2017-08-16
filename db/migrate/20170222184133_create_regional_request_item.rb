class CreateRegionalRequestItem < ActiveRecord::Migration[5.0]
  def change
    create_table :regional_request_items do |t|
      t.references :regional_request, foreign_key: true
      t.references :fdp, foreign_key: true
      t.decimal :number_of_beneficiaries

      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
