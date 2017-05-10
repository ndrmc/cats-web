namespace :cats do
  namespace :delivery_import do
    desc "Migrates delivery_imports table from the excel entry into deliveries table"
    task import: :environment do
      log = ActiveSupport::Logger.new('log/delivery_import.log')
      start_time = Time.now
      log.info "Started reading delivery_import records at #{start_time}"
     
      success = 0
      fail = 0
      failed_rows = ''
      DeliveryImport.all.each do |di|
        next if di.imported?
        log.info "------------------#{di.id}-------------------------"


          delivery = Delivery.find_by_receiving_number(di.grn)
          transporter = Transporter.find_by_name(di.transporter_name)
          fdp_id= Fdp.find_by_name(di.destination).id
          operation_id = Operation.find_by(year: di.allocation_year, round: di.round, program_id: 1).id       
          commodity_id = Commodity.find_by_name(di.commodity_type).id          
          uom_id =  UnitOfMeasure.find_by_code('MT').id

        begin
          if (delivery.nil?)
           
            delivery = Delivery.new(
               receiving_number: di.grn,
               transporter_id: transporter ? transporter.id : nil,
               fdp_id: fdp_id,
               gin_number: di.gin,
               requisition_number: di.requisition_no,
               received_by: di.received_by ? di.received_by : "" ,
               received_date: di.received_date,
               operation_id:operation_id,
               draft: true,
               delivery_id_guid:SecureRandom.uuid,
               remark: di.program
            )

            else 
                delivery.draft = true  
            end

            #if delivery is saved check if this is another delivery_detail with a different commodity_id
            if !delivery.delivery_details.where(commodity_id: commodity_id, received_quantity: di.quantity_received_qtl.to_f * 0.1).empty?

                log.info "This delivery_import record (#{di.id}) seems to be a duplicate of delivery record #{delivery.id}"
                log.info "delivery: #{delivery.receiving_number} , commodity_id:#{commodity_id}"
            else
              delivery.delivery_details.build(
                                      commodity_id: commodity_id,
                                      uom_id: uom_id,
                                      sent_quantity: di.dispatch_quantity.to_f*0.1,
                                      received_quantity: di.quantity_received_qtl.to_f*0.1,
                                      guid_ref_delivery_id: delivery.delivery_id_guid
              )
              delivery.save!


            end
           success += 1
           di.imported = true
           di.save!
           log.info "delivery_import id  #{di.id}  saved as Delivery #{ delivery.id}"
           log.info "Updated #{success} Delivery record(s)"
         rescue Exception => e
           fail += 1
           failed_rows += ",#{di.id}"
           di.imported = false
           di.save!
           log.info "Exception while trying to save delivery_import, id: #{di.id}"
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
  end
end


