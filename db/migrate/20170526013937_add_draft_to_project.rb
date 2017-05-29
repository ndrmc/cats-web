class AddDraftToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :draft, :boolean, default: false
  end
end
