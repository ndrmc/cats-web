# == Schema Information
#
# Table name: adjustments
#
#  id                    :integer          not null, primary key
#  stock_take_id         :integer          not null
#  stock_take_item_id    :integer          not null
#  commodity_id          :integer          not null
#  commodity_category_id :integer          not null
#  amount                :decimal(, )      not null
#  adjustment_type       :integer          not null
#  reason                :string
#  created_by            :integer
#  modified_by           :integer
#  deleted_at            :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Adjustment < ApplicationRecord
    include Postable

    belongs_to :stock_take_item
    belongs_to :stock_take

    enum adjustment_type:  {gain: 0, loss: 1}
    
end
