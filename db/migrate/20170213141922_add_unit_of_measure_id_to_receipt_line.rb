class AddUnitOfMeasureIdToReceiptLine < ActiveRecord::Migration[5.0]
  def change
    add_reference :receipt_lines, :unit_of_measure, foreign_key: true
  end
end
