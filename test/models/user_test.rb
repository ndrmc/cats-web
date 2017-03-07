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
#  region                 :string
#  organization_unit      :string
#  hub                    :string
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
#  datePreference         :date
#  mobileNo               :string
#  numberOfLogins         :integer
#  regionalUser           :boolean
#  hubUser                :boolean
#  case_team              :integer
#  Admin                  :boolean
#  IsCaseTeam             :boolean
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
