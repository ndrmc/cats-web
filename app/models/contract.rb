# == Schema Information
#
# Table name: contracts
#
#  id           :integer          not null, primary key
#  contract_no  :string           not null
#  transport_id :integer
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Contract < ApplicationRecord
  has_many :transport_orders

end
