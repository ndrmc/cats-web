# == Schema Information
#
# Table name: receipts
#
#  id                      :integer          not null, primary key
#  grn_no                  :string           not null
#  received_date           :datetime
#  hub_id                  :integer
#  warehouse_id            :integer
#  delivered_by            :string
#  supplier_id             :integer
#  transporter_id          :integer
#  plate_no                :string
#  trailer_plate_no        :string
#  weight_bridge_ticket_no :string
#  weight_before_unloading :decimal(, )
#  weight_after_unloading  :decimal(, )
#  storekeeper_name        :string
#  waybill_no              :string
#  purchase_request_no     :string
#  purchase_order_no       :string
#  invoice_no              :string
#  commodity_source_id     :integer
#  program_id              :integer
#  store_id                :integer
#  drivers_name            :string
#  remark                  :text
#  draft                   :boolean          default(FALSE)
#  created_by              :integer
#  modified_by             :integer
#  deleted                 :boolean          default(FALSE)
#  deleted_at              :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Receipt < ApplicationRecord
    include Postable
    acts_as_paranoid

    has_many :receipt_lines 

    after_save :pre_post

end
