# == Schema Information
#
# Table name: programs
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  code        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Program < ApplicationRecord
end
