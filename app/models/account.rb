# == Schema Information
#
# Table name: accounts
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  code        :integer
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#

class Account < ApplicationRecord
    enum code: {
        receivable: 1,
        allocated: 2,
        received: 3,
        dispatched: 4,
        delivered: 5,
        lost: 6,
        stock: 7,
        distributed: 8,
        repaid: 9,
        statistics: 10
    }

    validates :name, presence: {messege: " is required!"}
    validates :name, uniqueness: true
end
