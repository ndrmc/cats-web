# == Schema Information
#
# Table name: bid_quotations
#
#  id                 :integer          not null, primary key
#  bid_id             :integer
#  transporter_id     :integer
#  bid_quotation_date :date
#  created_by         :integer
#  modified_by        :integer
#  deleted_at         :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class BidQuotation < ApplicationRecord
  belongs_to :bid
  belongs_to :transporter
  has_many :bid_quotation_details, dependent: :destroy

  validates_numericality_of :tariff, greater_than_or_equal_to: 0, only_decimal: true, allow_nil: true
end
