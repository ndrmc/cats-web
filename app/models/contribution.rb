# == Schema Information
#
# Table name: contributions
#
#  id                :integer          not null, primary key
#  donor_id          :integer
#  contribution_type :integer
#  amount            :decimal(, )
#  created_by        :integer
#  modified_by       :integer
#  deleted           :boolean          default(FALSE)
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#


class Contribution < ApplicationRecord
    enum contribution_type: { kind: 0, cash: 1 }
end
