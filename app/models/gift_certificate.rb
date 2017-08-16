# == Schema Information
#
# Table name: gift_certificates
#
#  id                     :integer          not null, primary key
#  reference_no           :string           not null
#  gift_date              :date
#  vessel                 :string
#  donor_id               :integer
#  eta                    :date
#  program_id             :integer
#  mode_of_transport_id   :integer
#  port_name              :string
#  status                 :integer          default("draft"), not null
#  customs_declaration_no :string
#  purchase_year          :string
#  expiry_date            :date
#  fund_type_id           :integer
#  account_no             :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  created_by             :integer
#  modified_by            :integer
#  deleted_at             :datetime
#  bill_of_loading        :string
#  amount                 :decimal(15, 2)
#  estimated_price        :decimal(15, 2)
#  estimated_tax          :decimal(15, 2)
#  fund_source_id         :integer
#  currency_id            :integer
#

class GiftCertificate < ApplicationRecord
  include Filterable

  scope :status, ->(status) { where status: status }
  scope :organization_id, ->(organization_id) { where organization_id: organization_id }

  enum status: [:draft, :approved, :canceled, :closed, :archived]

  belongs_to :program
  belongs_to :commodity
  belongs_to :currency
  belongs_to :mode_of_transport
  belongs_to :fund_source
  belongs_to :fund_type
  belongs_to :organization

  validates :reference_no, uniqueness: true

  validates :reference_no, presence: true
  validates :gift_date, presence: true
  validates :organization_id, presence: true
  validates :program_id, presence: true
  validates :fund_type_id, presence: true
  validates :fund_source_id, presence: true
  validates :commodity_id, presence: true
  validates :mode_of_transport_id, presence: true


  before_destroy :check_for_status


  private
  def check_for_status
    if self.status != status[0] then
         return false
    end

  end


end
