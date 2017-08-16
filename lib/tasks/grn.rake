namespace :cats do
  namespace :grn_import do
    desc "Migrates grn_imports table from the excel entry into receipts table"
    task import: :environment do
      log = ActiveSupport::Logger.new('log/grn_import.log')
      start_time = Time.now
      log.info "Started reading grn_import records at #{start_time}"
     
      success = 0
      fail = 0
      failed_rows = ''
      GrnImport.all.each do |gi|
        next if gi.imported?
        log.info "------------------#{gi.id}-------------------------"


          grn = Receipt.find_by_grn_no(gi.grn)
          project = Project.find_by_project_code(gi.project_code)
          project_id = project.id
          commodity_source  = project.commodity_source
          hub_id = Hub.find_by_name(gi.hub)
          warehouse_id = Warehouse.find_by_name(gi.warehouse)
          supplier_id = Supplier.find_by_name(gi.supplier)
          transporter = Transporter.find_by_name(gi.transporter_name)
          commodity_id = Commodity.find_by_name(gi.commodity_type).id
          commodity_cat_id = CommodityCategory.find_by_name(gi.commodity_class).id
          uom_id =  UnitOfMeasure.find_by_code('MT').id

        begin
          if (grn.nil?)
           
            grn = Receipt.new(
                grn_no: gi.grn,
                received_date:gi.received_date,
                hub_id:hub_id,
                warehouse_id:warehouse_id,
                delivered_by:'',
                supplier_id:supplier_id ? supplier_id : nil,
                transporter_id:transporter ? transporter.id : nil,
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
                commodity_source_id: commodity_source,
                program_id: Program.find_by_name('Relief').id,
                store_id:'',
                drivers_name:'',
                remark:'',
                draft: true,
                receiveid: SecureRandom.uuid
            )

            else 
                grn.draft = true  
            end

            #if grn is saved check if this is another receipt_item with a different commodity_id
            if !grn.receipt_lines.where(commodity_id: commodity_id, quantity: gi.received_in_mt,project_id: project_id).empty?

                log.info "This grn_import record (#{gi.id}) seems to be a duplicate of receipt record #{grn.id}"
                log.info "grn: #{grn.grn_no} , commodity_id:#{commodity_id}"
            else
              grn.receipt_lines.build(
                                       commodity_category_id: commodity_cat_id,
                                       commodity_id: commodity_id,
                                       quantity: gi.received_in_mt,
                                       project_id: project_id,
                                       unit_of_measure_id:uom_id,
                                       receive_id: grn.receiveid,
                                       receive_item_id: SecureRandom.uuid
              )
              grn.save!


            end
           success += 1
           gi.imported = true
           gi.save!
           log.info "grn_import id  #{gi.id}  saved as Receipt #{ grn.id}"
           log.info "Updated #{success} Receipt(grn) record(s)"
         rescue Exception => e
           fail += 1
           failed_rows += ",#{gi.id}"
           gi.imported = false
           gi.save!
           log.info "Exception while trying to save grn_import, id: #{gi.id}"
           log.info 'Cause: '+ e.message
           log.info e.backtrace.join("\n")
         end


        log.info "------------------//-------------------------"
      end
      log.info "Copied #{success} grn_import records successfully."
      log.info "Failed records: #{fail}"
      log.info "Failed rows \n #{ failed_rows }"

      
      end_time = Time.now
      duration = (end_time - start_time ) / 1.minute
      log.info "Task finished at #{end_time} and lasted #{duration} minutes."
      log.close
    end
   
    desc "update received date field of imported receipts"
    # This task is used to update received_date fields that were incorrectly imported from the grn_imports table. 
    # The dates on grn_import table are in Ethiopian calendar and have different formats.
    # This is to keep an additional string field for the imported date fields and later filter and update them 
    # by converting to a Gregorian date.
    task update_dates: :environment do
      log = ActiveSupport::Logger.new('log/update_received_date.log')
      start_time = Time.now
      log.info "Started updating received dates in receipts at #{start_time}"
     
      success = 0
      fail = 0
      failed_rows = ''
      
        receipts_with_wrong_dates = Receipt.where(:grn_no => GrnImport.all.pluck(:grn))
        receipts_with_wrong_dates.all.each do |r|

          begin
            grn_import = GrnImport.find_by_grn(r.grn_no)
            r.received_date = DateTime.now
            r.received_date_ec = grn_import.received_date
            success += 1            
            r.save!
            log.info "updated #{success} grn_import records successfully."
          rescue Exception => e
            fail += 1
            failed_rows += ",#{r.id}"
            log.info 'Cause: '+ e.message
            log.info e.backtrace.join("\n")
          end

      end
      log.info "updated #{success} grn_import records successfully."
      log.info "Failed records: #{fail}"
      log.info "Failed rows \n #{ failed_rows }"

      
      end_time = Time.now
      duration = (end_time - start_time ) / 1.minute
      log.info "Task finished at #{end_time} and lasted #{duration} minutes."
      log.close
    end
  end
end


