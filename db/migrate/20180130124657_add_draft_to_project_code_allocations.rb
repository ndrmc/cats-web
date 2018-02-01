class AddDraftToProjectCodeAllocations < ActiveRecord::Migration[5.0]
  def change
    add_column :project_code_allocations, :draft, :boolean
  end
end
