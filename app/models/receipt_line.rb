# == Schema Information
#
# Table name: receipt_lines
#
#  id                    :integer          not null, primary key
#  receipt_id            :integer
#  commodity_category_id :integer
#  commodity_id          :integer
#  quantity              :decimal(, )
#  project_id            :integer
#  created_by            :integer
#  modified_by           :integer
#  deleted               :boolean          default(FALSE)
#  deleted_at            :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class ReceiptLine < ApplicationRecord


    belongs_to :receipt 
end
