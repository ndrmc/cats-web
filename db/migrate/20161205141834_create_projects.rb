class CreateProjects < ActiveRecord::Migration
  def change
    create_table(:projects) do |t|
      t.string :project_code
      t.integer :commodity_id
      t.integer :commodity_source
      t.integer :organization_id
      t.decimal :amount
      t.integer :unit_of_measure_id
      t.date :publish_date

      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at

      t.timestamps
    end
    add_index(:projects, :project_code)
  end
end
