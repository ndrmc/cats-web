class AddOrganizationToDispatchItem < ActiveRecord::Migration[5.0]
  def change
    add_reference :dispatch_items, :organization, foreign_key: true
  end
end
