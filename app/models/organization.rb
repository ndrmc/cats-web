# == Schema Information
#
# Table name: organizations
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  long_name   :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Organization < ApplicationRecord
end
