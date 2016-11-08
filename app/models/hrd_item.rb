# == Schema Information
#
# Table name: hrd_items
#
#  id             :integer          not null, primary key
#  hrd_id         :integer
#  woreda_id      :integer
#  duration       :integer
#  starting_month :integer
#  beneficiary    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class HrdItem < ApplicationRecord
  belongs_to :hrd

  def woreda
    Location.find_by(id: self.woreda_id)
  end
  
end
