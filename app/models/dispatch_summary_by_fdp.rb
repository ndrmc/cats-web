# app/models/dispatch_summary_by_fdp.rb
class DispatchSummaryByFdp < ActiveRecord::Base
  self.primary_key = "AlloFDP, AllOpID, AlloCommID, AlloReqNo"


  belongs_to :fdp
end
