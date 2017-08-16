# == Schema Information
#
# Table name: fdp_contacts
#
#  id          :integer          not null, primary key
#  full_name   :string           not null
#  mobile      :string
#  email       :string
#  fdp_id      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#

require 'test_helper'

class FdpContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
