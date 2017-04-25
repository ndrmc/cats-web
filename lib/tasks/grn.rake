namespace :cats do
  namespace :grn do
    desc "Migrates grn_imports table from the excel entry into receipts table"
    task import: :environment do
      Rails.logger.info "Started reading grn_import records."
      success = 0
      fail = 0
      failed_rows = ''
      GrnImport.all.each do |gi|
        Rails.logger.info "------------------#{gi.id}-------------------------"


          grn = Receipt.find_by_grn_no(gi.grn)
          project_id = Project.find_by_project_code(gi.project_code).id
          hub_id = Hub.find_by_name(gi.hub)
          warehouse_id = Warehouse.find_by_name(gi.warehouse)
          supplier_id = Supplier.find_by_name(gi.supplier)
          transporter_id = Transporter.find_by_name(gi.transporter).id
          commodity_id = Commodity.find_by_name(gi.commodity_type).id
          commodity_cat_id = CommodityCategory.find_by_name(gi.commodity_class).id
          uom_id = UnitOfMeasure.find_by_name('mt').id

        begin
          if (grn.nil?)

            operation_id = Operation.where(year: '2016', round: gi.round, program_id: 1)
            grn = Receipt.new(
                grn_no:grn,
                received_date:received_date,
                hub_id:hub_id,
                warehouse_id:warehouse_id,
                delivered_by:'',
                supplier_id:supplier_id,
                transporter_id:transporter_id,
                plate_no:gi.plat_no,
                trailer_plate_no:gi.trailer_no,
                weight_bridge_ticket_no:'',
                weight_before_unloading:'',
                weight_after_unloading:'',
                storekeeper_name: gi.storekeeper,
                waybill_no:gi.waybill_no,
                purchase_request_no:'',
                purchase_order_no:'',
                invoice_no:'',
                commodity_source_id:'',
                program_id: Program.find_by_name('Relief').id,
                store_id:'',
                drivers_name:'',
                remark:'',
                draft: true
            )


            end

            #if grn is saved check if this is another dispatch_item with a different commodity_id
            if !grn.receipt_lines.where(commodity_id: commodity_id, quantity: gi.mt_dispatched,project_id: project_id).empty?

                Rails.logger.info "This grn_import record (#{gi.id}) seems to be a duplicate of receipt record #{grn.id}"
                Rails.logger.info "grn: #{grn.grn_no} , commodity_id:#{commodity_id}"
            else
              grn.receipt_lines.build(
                                       commodity_category_id: commodity_cat_id,
                                       commodity_id: commodity_id,
                                       quantity: gi.received_in_mt,
                                       project_id: project_id,
                                       unit_of_measure_id:uom_id
              )
              grn.save!


            end
           success += 1
           Rails.logger.info "grn_import id  #{gi.id}  saved as Recipt #{ gin.id}"
           Rails.logger.info "Updated #{success} Receipt(grn) record(s)"
         rescue Exception => e
           fail += 1
           failed_rows += ",#{gi.id}"
           Rails.logger.info "Exception while trying to save grn_import, id: #{gi.id}"
           Rails.logger.info 'Cause: '+ e.message
           Rails.logger.info e.backtrace.join("\n")
         end


        Rails.logger.info "------------------//-------------------------"
      end
      Rails.logger.info "Copied #{success} grn_import records successfully."
      Rails.logger.info "Failed records: #{fail}"
      Rails.logger.info "Failed rows \n #{ failed_rows }"
  end
  end
end


