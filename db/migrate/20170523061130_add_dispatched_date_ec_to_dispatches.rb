class AddDispatchedDateEcToDispatches < ActiveRecord::Migration[5.0]
  def change
     add_column :dispatches, :dispatched_date_ec, :string
  end
end
