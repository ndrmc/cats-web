# == Schema Information
#
# Table name: store_owners
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  long_name   :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class StoreOwner < ApplicationRecord
end
