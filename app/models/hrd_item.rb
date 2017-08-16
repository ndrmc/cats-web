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
#  region_id      :integer
#  zone_id        :integer
#

class HrdItem < ApplicationRecord

  before_save :populate_region_and_ids

  belongs_to :hrd

  def woreda
    if @woreda 
      return @woreda 
    end
    
    return @woreda = Location.find_by(id: self.woreda_id)
  end

  def populate_region_and_ids
    woreda_ancestor_ids = woreda.ancestor_ids

    self.region_id = woreda_ancestor_ids[0]     
    self.zone_id = woreda_ancestor_ids[1]     
  end
  
end
