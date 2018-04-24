# == Schema Information
#
# Table name: requisition_items
#
#  id             :integer          not null, primary key
#  requisition_id :integer
#  fdp_id         :integer
#  beneficiary_no :integer          not null
#  amount         :decimal(, )      not null
#  contingency    :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  created_by     :integer
#  modified_by    :integer
#  deleted_at     :datetime
#

class RequisitionItem < ApplicationRecord
  belongs_to :requisition
  belongs_to :fdp

  def amount
    if self.read_attribute(:contingency).to_f > 0
         self.read_attribute(:contingency).to_f + self.read_attribute(:amount).to_f
    else
       self.read_attribute(:amount).to_f
    end
    
  end
  
  def amout_without_contingency
     self.read_attribute(:amount).to_f
  end
  
end
