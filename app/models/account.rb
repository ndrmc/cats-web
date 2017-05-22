# == Schema Information
#
# Table name: accounts
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  type        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#

class Account < ApplicationRecord
    enum code: {
        borrowed: 0,
        purchased: 1,
        pledged: 2,
        allocated: 3,
        received: 4,
        dispatched: 5,
        delivered: 6,
        lost: 7,
        stock: 8,
        distributed: 9,
        repaid: 10,
        statistics: 11
    }

    validates :name, presence: {messege: " is required!"}
    validates :name, uniqueness: true
end
