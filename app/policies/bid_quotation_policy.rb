class BidQuotationPolicy < ApplicationPolicy
    
    
 def index?
    @current_user.permission('BidQuotation', :guest)
 end

 # GET /bid_quotations/1
 # GET /bid_quotations/1.json
 def show?
    @current_user.permission('BidQuotation', :guest)
 end

 # GET /bid_quotations/new
 def new?
    @current_user.permission('BidQuotation', :clerk)
 end

 # GET /bid_quotations/1/edit
 def edit?
    @current_user.permission('BidQuotation', :clerk)
 end

 # POST /bid_quotations
 # POST /bid_quotations.json
 def create?
    @current_user.permission('BidQuotation', :clerk)
 end

 # PATCH/PUT /bid_quotations/1
 # PATCH/PUT /bid_quotations/1.json
 def update?
    @current_user.permission('BidQuotation', :clerk)
 end

 # DELETE /bid_quotations/1
 # DELETE /bid_quotations/1.json
 def destroy?
    @current_user.permission('BidQuotation', :clerk)
 end

 def update_tariff?
    @current_user.permission('BidQuotation', :clerk)
 end

 def delete_bid_quuotation_detail?
    @current_user.permission('BidQuotation', :clerk)
 end

end

