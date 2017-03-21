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
#  hrd_id            :integer
#  pledged_date      :datetime
#

class Contribution < ApplicationRecord
    enum contribution_type: { kind: 0, cash: 1 }

    belongs_to :donor
    belongs_to :hrd
end
