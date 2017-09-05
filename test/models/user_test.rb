# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  language               :string
#  keyboard               :string
#  calendar               :string
#  default_uom            :string
#  organization_unit      :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  created_by             :integer
#  modified_by            :integer
#  deleted_at             :datetime
#  is_active              :boolean          default(TRUE)
#  first_name             :string
#  last_name              :string
#  date_preference        :date
#  mobile_no              :string
#  number_of_logins       :integer
#  region_user            :boolean
#  user_types             :integer
#  location_id            :integer
#  hub_id                 :integer
#  department_id          :integer
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
