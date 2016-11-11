# == Schema Information
#
# Table name: mode_of_transports
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ModeOfTransport < ApplicationRecord
end
