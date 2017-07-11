# app/models/dispatch_summary_by_fdp.rb
class DispatchSummaryByFdp < ActiveRecord::Base
  self.primary_key = "allo_fdp, allo_op_id, allo_comm_id, allo_req_no"


  belongs_to :fdp
end