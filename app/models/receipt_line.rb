# == Schema Information
#
# Table name: receipt_lines
#
#  id                    :integer          not null, primary key
#  receipt_id            :integer
#  commodity_category_id :integer
#  commodity_id          :integer
#  quantity              :decimal(15, 2)
#  project_id            :integer
#  created_by            :integer
#  modified_by           :integer
#  deleted               :boolean          default(FALSE)
#  deleted_at            :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  unit_of_measure_id    :integer
#  receive_id            :string(36)       not null
#  receive_item_id       :string(36)       not null
#

class ReceiptLine < ApplicationRecord
    acts_as_paranoid

    belongs_to :commodity_category
    belongs_to :commodity
    belongs_to :unit_of_measure
    belongs_to :receipt 
    belongs_to :project 
end
