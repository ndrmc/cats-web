class CreateRegionalRequest < ActiveRecord::Migration[5.0]
  def change
    create_table :regional_requests do |t|
      t.references :operation, foreign_key: true
      t.string :reference_number
      t.integer :region_id
      t.references :ration, foreign_key: true
      t.datetime :requested_date
      t.references :program, foreign_key: true
      t.text :remark

      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
