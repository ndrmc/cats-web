# == Schema Information
#
# Table name: requisition_items
#
#  id                 :integer          not null, primary key
#  requisition_id     :integer
#  commodity_id       :integer
#  unit_of_measure_id :integer
#  fdp_id             :integer
#  beneficiary_no     :integer          not null
#  amount             :decimal(, )      not null
#  contingency        :decimal(, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  created_by         :integer
#  modified_by        :integer
#  deleted_at         :datetime
#

class RequisitionItem < ApplicationRecord
  belongs_to :requisition
end
