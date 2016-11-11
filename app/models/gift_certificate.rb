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
#  bill_of_ladding        :string
#  amount                 :float
#  estimated_price        :float
#  estimated_tax          :float
#  purchase_year          :string
#  expiry_date            :date
#  fund_type_id           :integer
#  account_no             :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class GiftCertificate < ApplicationRecord
  enum status: [:draft, :approved, :canceled, :closed, :archived]
  has_many :gift_certificate_items
end
