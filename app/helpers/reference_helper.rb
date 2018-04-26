module ReferenceHelper
    
    def get_reference_numbers_by_requisition_no(requisition_nos)
        @reference_numbers = RegionalRequest.includes(:requisitions).where(:'requisitions.requisition_no' => requisition_nos).distinct.pluck(:reference_number)
        return  @reference_numbers
    end

    def get_reference_numbers_by_requisition_id(requistion_ids)
        @reference_numbers = RegionalRequest.includes(:requisitions).where(:'requisitions.id' => requistion_ids).distinct.pluck(:reference_number)
        return  @reference_numbers
    end
end