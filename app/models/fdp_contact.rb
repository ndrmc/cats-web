# == Schema Information
#
# Table name: fdp_contacts
#
#  id         :integer          not null, primary key
#  full_name  :string           not null
#  mobile     :string
#  email      :string
#  fdp_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FdpContact < ApplicationRecord
  belongs_to :fdp
end
