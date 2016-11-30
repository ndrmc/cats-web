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
#  created_by   :integer
#  modified_by  :integer
#  deleted_at   :datetime
#

class Contract < ApplicationRecord
  has_many :transport_orders

end
