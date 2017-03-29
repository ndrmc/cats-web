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
#  date_preference        :date
#  mobile_no              :string
#  number_of_logins       :integer
#  region_user            :boolean
#  hub_user               :boolean
#  user_type_id           :integer
#

class User < ApplicationRecord
  rolify
  after_create :assign_default_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def name
    first_name.to_s + ' ' + last_name.to_s
  end

  def assign_default_role
    self.add_role(:guest) if self.roles.blank?
  end


  def active_for_authentication?
    super and self.is_active?
  end


  def inactive_message
    "Your account is not active."
  end

  enum role_types: {
        admin:2,
        case_team:3,
        hub:4,
        regional:5
    }   

end
