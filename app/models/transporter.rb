# == Schema Information
#
# Table name: transporters
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  code          :string           not null
#  ownership     :string
#  vehicle_count :integer
#  lift_capacity :decimal(, )
#  capital       :decimal(, )
#  employees     :integer
#  contact       :string
#  contact_phone :string
#  remark        :text
#  status        :integer          default("active"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Transporter < ApplicationRecord
  enum status: [:active, :inactive]
  has_many :transporter_addresses
end
