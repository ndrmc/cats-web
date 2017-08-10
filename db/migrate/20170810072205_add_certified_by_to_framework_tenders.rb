class AddCertifiedByToFrameworkTenders < ActiveRecord::Migration[5.0]
  def change
    add_column :framework_tenders, :certified_by, :integer
  end
end
