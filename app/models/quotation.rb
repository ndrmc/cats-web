# == Schema Information
#
# Table name: quotations
#
#  id                :integer          not null, primary key
#  bid_submission_id :integer
#  store_id          :integer
#  destination_id    :integer
#  tariff_quote      :decimal(, )
#  remark            :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  created_by        :integer
#  modified_by       :integer
#  deleted_at        :datetime
#

class Quotation < ApplicationRecord
  belongs_to :bid_submission

  def source_warehouse
    Store.find_by(id: store_id)
  end

  def destination
    Location.find_by(id: destination_id)
  end
end
