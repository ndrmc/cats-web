class ReceiptsController < ApplicationController
  before_action :authenticate_user!
  def index
    authorize Receipt
    if params[:find].present?
      @receipts = Receipt.where grn_no: params[:grn_no]
      return
    end

    if params[:project].present? && params[:hub].present?
      filter_map = {hub_id: params[:hub], receipt_lines: { project_id: params[:project]}}

      if params[:received_date ].present?
        dates = params[:received_date].split(' - ').map { |d| Date.parse d }

        filter_map[:received_date] = dates[0]..dates[1]
      end

      if params[:status ]
        filter_map[:draft ] = params[:status ] == 'Draft'
      end

      @receipts = Receipt.joins( :receipt_lines ).where( filter_map ).distinct
    else
      @receipts = []
    end

  end


  def new
    authorize Receipt
 
    if params[:id] 
      @project_id = params[:id]
      @organization = Project.where(:id => params[:id])
      @organization_id = @organization.pluck(:organization_id)
      @commodity_id =  @organization.pluck(:commodity_id)
      @commodity_category_id = Commodity.where(:id => @commodity_id).pluck(:commodity_category_id)
      @unit_of_measure_id =  @organization.pluck(:unit_of_measure_id)
    end
    
    @receipt = Receipt.new
    @receipt.commodity_source_id = 1
  end


  def create
    authorize Receipt
    recept_lines_hash = receipt_params[:receipt_lines][0...-1]
    receipt_lines = recept_lines_hash.collect { |h| ReceiptLine.new( h)}

    receipt_map = receipt_params.except(:receipt_lines)

    receipt_map[:receipt_lines] = receipt_lines

    @receipt = Receipt.new( receipt_map )
    @receipt.created_by = current_user.id
    @receipt.receiveid = "N/A" # to be removed: field included for data import purposes only
    @receipt.receipt_lines.each do |rl|
      rl.receive_id = "N/A" # to be removed: field included for data import purposes only
      rl.receive_item_id = "N/A" # to be removed: field included for data import purposes only
    end


    
      if @receipt.save
        if params[:submit_receipt_and_new]== "submit-receipt-and-new  "
          format.js {}
        elsif params[:submit_receipt] == "Create Receipt"
           flash[:notice] = "Receipt was successfully created." 
          render :js => "window.location = '#{receipts_path}'"
        end
      else
        format.html { render :new }
      end
    
  end

  def edit
    authorize Receipt
    @receipt = Receipt.find(params[:id])
    @project_id = @receipt.receipt_lines.pluck(:project_id)
    @edit = true
  end

  def update
    authorize Receipt
    @receipt = Receipt.find(params[:id])
    @receipt.modified_by = current_user.id
    receipt_line_ids = @receipt.receipt_lines.collect { |rl| rl.id }

    recept_lines_hash = receipt_params[:receipt_lines][0...-1]

    deleted_receipt_line_ids = receipt_line_ids -  recept_lines_hash.collect { |r| r[:id].to_i }

    ReceiptLine.where( :id => deleted_receipt_line_ids).destroy_all

    receipt_lines = recept_lines_hash.collect do |h|
      if h[:id] != nil
        ReceiptLine.find(h[:id])
      else
        ReceiptLine.new( h)
      end
    end

    receipt_map = receipt_params.except(:receipt_lines)
    receipt_map[:receiveid] = "N/A" # to be removed: field included for data import purposes only
    receipt_lines.each do |rl|
      rl.receive_id = "N/A" # to be removed: field included for data import purposes only
      rl.receive_item_id = "N/A" # to be removed: field included for data import purposes only
    end
    receipt_map[:receipt_lines] = receipt_lines
   
    
    if @receipt.update( receipt_map )
           flash[:notice] = "Receipt was successfully updated." 
           render :js => "window.location = '#{receipts_path}'"
    else
      respond_to do |format|
        format.html { render :edit }
      end
    end
  end

  def getProjectCodeStatus
    project_quantity = Project.where(:id => params[:id]).pluck(:amount)
    receipt_quantity = ReceiptLine.where(:project_id => params[:id]).sum(:quantity)

    respond_to do |format| 
    
         format.json{
          render :json => {
        :allocated => project_quantity,
        :received => receipt_quantity
      }
    }
    end
  end
  
  private

  def receipt_params
    params.require(:receipt).permit( :grn_no, :store_id, :received_date, :storekeeper_name, :waybill_no, :hub_id, :warehouse_id, :commodity_source_id,:donor_id,
                                     :weight_bridge_ticket_no, :transporter_id, :weight_before_unloading,:weight_after_unloading, :plate_no, :trailer_plate_no, :drivers_name, :remark,
                                     :receipt_lines => [:id, :commodity_category_id, :commodity_id, :unit_of_measure_id,  :quantity, :project_id]
                                     )

  end
end
