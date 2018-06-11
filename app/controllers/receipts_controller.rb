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

      @receipts = Receipt.includes(:receipt_lines).where( filter_map ).distinct
    else
      @receipts = []
    end

  end

def show

  
end
def receipt_report_items

  if params[:hub].present?
       filter_map = {'receipts.hub_id': params[:hub]}
          if params[:received_date].present?
            dates = params[:received_date].split(' - ').map { |d| Date.parse d }
            filter_map[:'receipts.received_date'] = dates[0]..dates[1]
            @date_min = dates[0]
            @date_max = dates[1]
          end
      end
     
      @receipts = ReceiptLine.joins(:unit_of_measure, :project, :commodity, receipt: [:organization,:transporter]).select('receipts.received_date,receipts.grn_no,receipts.waybill_no,
      organizations.name AS donor',
      'projects.project_code',
      'transporters.name as transporter',
      'receipts.plate_no as plate_no',
      'receipts.trailer_plate_no as trailer_plate_no',
      'receipts.drivers_name',
      'receipt_lines.commodity_category_id as commodity_class_id',
      'commodities.name as commodity_name',
      'quantity', 
      'unit_of_measures.name AS unit',
      'storekeeper_name',
      'receipts.store_id'
      ).where(filter_map) 

       @hub = Hub.find_by(id: params[:hub])

      respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=\"#{@hub&.name} - " + Time.now.strftime('%m/%d/%Y') + ".xlsx\""
      }
    end

    
end

def receipt_report
       
       if params[:hub].present?
       filter_map = {'receipts.hub_id': params[:hub]}
          if params[:received_date].present?
            dates = params[:received_date].split(' - ').map { |d| Date.parse d }
            filter_map[:'receipts.received_date'] = dates[0]..dates[1]
            @date_min = dates[0]
            @date_max = dates[1]
          end
      end
     
      @receipts = ReceiptLine.joins(:unit_of_measure, :project, :commodity, receipt: [:organization,:transporter]).select('receipts.received_date,receipts.grn_no,receipts.waybill_no,
      organizations.name AS donor',
      'projects.project_code',
      'transporters.name as transporter',
      'receipts.plate_no as plate_no',
      'receipts.trailer_plate_no as trailer_plate_no',
      'receipts.drivers_name',
      'receipt_lines.commodity_category_id as commodity_class_id',
      'commodities.name as commodity_name',
      'quantity', 
      'unit_of_measures.name AS unit',
      'storekeeper_name',
      'receipts.store_id'
      ).where(filter_map) 

       @hub = Hub.find_by(id: params[:hub])
end



def check_stock    
  @hub_id = receipt_params["hub_id"]
  @warehouse_id = receipt_params["warehouse_id"]
  @project_id = receipt_params["proj_id"]

  project = Project.find(@project_id);
  @allocated_quantity = 0
  if project.amount.present?
    @allocated_quantity = UnitOfMeasure.find(project.unit_of_measure_id).to_ref(project.amount)
  end
  receipt_journal = Journal.find_by({'code': :goods_received})
  stock_account = Account.find_by({'code': :stock})
  @hub_received = PostingItem.where(journal_id: receipt_journal, account_id: stock_account.id, hub_id: @hub_id, project_id: @project_id).sum(:quantity)
  @total_received = PostingItem.where(journal_id: receipt_journal, account_id: stock_account.id, project_id: @project_id).sum(:quantity)
  @progress = ((@total_received / @allocated_quantity) * 100).round(2)
  @data = {allocated_quantity: @allocated_quantity, hub_received: @hub_received, total_received: @total_received, progress: @progress}
  respond_to do |format|
      format.html
      format.json { render :json => @data.to_json }
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

  def get_commoidty_source
   
    @project = Project.find(params[:project_id])
    @commodity_source = CommoditySource.find(@project.commodity_source_id).name
    @local_purchase = false
    if @commodity_source == "Local Purchase"
        @local_purchase = true
    end
   respond_to do |format|
            format.html
            format.json { render :json => @local_purchase.to_json }
        end
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
         respond_to do |format|
            format.html { render :new }
              format.json { render json: @receipt.errors, status: :unprocessable_entity }
              format.js
        end
      end
    
  end

  def edit
    authorize Receipt
    @receipt = Receipt.find(params[:id])
    @project_id = @receipt.receipt_lines.pluck(:project_id)
    @edit = true
  end

   def return_receipt_detail
     receipts = ReceiptLine.where(:receipt_id => params[:id])
     respond_to do |format|
       format.json do
            render :json =>  receipts.to_json(:only => [:quantity],:include => {:commodity => {:only => :name}, :project => {:only => :project_code}, :unit_of_measure => {:only => :name}})
         end
    end
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
        receipt_quantity = 0
        project = Project.find(params[:id]);
         if project.amount.blank?
           project_quantity = 0
         else
           project_quantity = UnitOfMeasure.find(project.unit_of_measure_id).to_ref(project.amount)
         end
    if params[:hub_id].present?
       receipt_lines = ReceiptLine.where(:project_id => params[:id]).joins(:receipt).where('receipts.hub_id = ?',params[:hub_id]);
          receipt_lines.each do |receipt_line|
            if !receipt_line.quantity.blank?
               receipt_quantity  += UnitOfMeasure.find(receipt_line.unit_of_measure_id).to_ref(receipt_line.quantity)
            end
       end
    else
       receipt_lines = ReceiptLine.where(:project_id => params[:id]);
       receipt_lines.each do |receipt_line|
    
         if !receipt_line.quantity.blank?
           receipt_quantity +=  UnitOfMeasure.find(receipt_line.unit_of_measure_id).to_ref(receipt_line.quantity)
         end
       end
       
    end
   
    puts receipt_quantity
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
    params.require(:receipt).permit( :grn_no, :store_id, :received_date, :storekeeper_name, :waybill_no, :hub_id, :warehouse_id, :commodity_source_id,:donor_id, :proj_id,
                                     :weight_bridge_ticket_no, :transporter_id, :weight_before_unloading,:weight_after_unloading, :plate_no, :trailer_plate_no, :drivers_name, :remark, :receipt_type, :receipt_type_id,
                                     :receipt_lines => [:id, :commodity_category_id, :commodity_id, :unit_of_measure_id,  :quantity, :project_id]
                                     )

  end
end
