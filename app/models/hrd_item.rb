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
#  created_by     :integer
#  modified_by    :integer
#  deleted_at     :datetime
#

class HrdItem < ApplicationRecord

  before_save :populate_region_id

  belongs_to :hrd

  def woreda
    if @woreda 
      return @woreda 
    end
    
    return @woreda = Location.find_by(id: self.woreda_id)
  end

  def populate_region_id
    self.region_id = woreda.ancestor_ids[0]      
  end
  
end
