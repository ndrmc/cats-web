# == Schema Information
#
# Table name: transporter_addresses
#
#  id             :integer          not null, primary key
#  transporter_id :integer
#  region_id      :integer
#  city           :string
#  subcity        :string
#  kebele         :string
#  house_no       :string
#  phone          :string
#  mobile         :string
#  email          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  created_by     :integer
#  modified_by    :integer
#  deleted_at     :datetime
#

class TransporterAddress < ApplicationRecord
  belongs_to :transporter, dependent: :destroy
end
