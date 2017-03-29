class CreateContribution < ActiveRecord::Migration[5.0]
  def change
    create_table :contributions do |t|
      t.references :donor, foreign_key: true
      t.integer :contribution_type
      t.decimal :amount

      t.integer :created_by
      t.integer :modified_by
      t.boolean :deleted, :default => false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
