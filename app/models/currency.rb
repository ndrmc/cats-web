# == Schema Information
#
# Table name: currencies
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  symbol      :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Currency < ApplicationRecord
end
