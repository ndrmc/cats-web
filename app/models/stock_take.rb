# == Schema Information
#
# Table name: stock_takes
#
#  id            :integer          not null, primary key
#  hub_id        :integer          not null
#  warehouse_id  :integer          not null
#  store_no      :integer
#  date          :date             not null
#  fiscal_period :integer
#  created_by    :integer
#  modified_by   :integer
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  draft         :boolean          default(TRUE)
#  title         :string           not null
#

class StockTake < ApplicationRecord
    include Postable 
    has_many :stock_take_items
    has_many :adjustments , through: :stock_take_items

    after_save :pre_post

  
    validates :title, presence: {messege: " is required!"}
    validates :hub_id, presence: {messege: " is required!"}
    validates :warehouse_id, presence: {messege: " is required!"}
    validates :date, presence: {messege: " is required!"}
    
end

