# == Schema Information
#
# Table name: posting_items
#
#  id                    :integer          not null, primary key
#  posting_item_code     :uuid
#  posting_id            :integer
#  account_id            :integer
#  journal_id            :integer
#  donor_id              :integer
#  hub_id                :integer
#  warehouse_id          :integer
#  store_id              :integer
#  stack_id              :integer
#  project_id            :integer
#  batch_id              :integer
#  program_id            :integer
#  operation_id          :integer
#  commodity_id          :integer
#  commodity_category_id :integer
#  quantity              :decimal(, )
#  region_id             :integer
#  zone_id               :integer
#  woreda_id             :integer
#  fdp_id                :integer
#  created_by            :integer
#  modified_by           :integer
#  deleted               :boolean          default(FALSE)
#  deleted_at            :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class PostingItem < ApplicationRecord
    belongs_to :posting
    
end
