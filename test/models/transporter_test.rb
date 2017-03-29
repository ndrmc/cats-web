# == Schema Information
#
# Table name: transporters
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  code              :string           not null
#  vehicle_count     :integer
#  lift_capacity     :decimal(, )
#  capital           :decimal(, )
#  employees         :integer
#  contact           :string
#  contact_phone     :string
#  remark            :text
#  status            :integer          default("active"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  created_by        :integer
#  modified_by       :integer
#  deleted_at        :datetime
#  ownership_type_id :integer
#

require 'test_helper'

class TransporterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
