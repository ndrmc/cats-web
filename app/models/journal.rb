# == Schema Information
#
# Table name: journals
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  code        :integer
#  created_by  :integer
#  modified_by :integer
#  deleted     :boolean          default(FALSE)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Journal < ApplicationRecord
    enum code: {
        beginning_inventory: 0,
        donation: 1,
        goods_received: 2,
        purchase: 3,
        dispatch_allocation: 4,
        goods_issue: 5,
        loan: 6,
        repayment: 7,
        transfer: 8,
        annual_inventory: 9,
        delivery: 10,
        distribution: 11,
        internal_movement: 12
    }
   
end
