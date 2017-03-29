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
  scope :donor_id, ->(donor_id) { where donor_id: donor_id }

  enum status: [:draft, :approved, :canceled, :closed, :archived]
end
