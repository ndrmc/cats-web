namespace :cats do
  namespace :gin_import do
    desc "Migrates git_imports table from the excel entry into dispatches table"
    task import: :environment do
      
      log = ActiveSupport::Logger.new('log/gin_import.log')
      start_time = Time.now
      log.info "Started reading git_import records at #{start_time}"
     
      success = 0
      fail = 0
      failed_rows = ''
      GitImport.all.each do |gi|
          next if gi.imported?

        log.info "------------------#{gi.id}-------------------------"

           transporter_id = Transporter.find_by_name(gi.transporter) ? Transporter.find_by_name(gi.transporter).id : nil
           fdp_id = Fdp.find_by_name(gi.fdp).id
           gin = Dispatch.find_by_gin_no(gi.gin)
           commodity_id = Commodity.find_by_name(gi.commodity_type)? Commodity.find_by_name(gi.commodity_type).id : ''
           commodity_cat_id = CommodityCategory.find_by_name(gi.commodity_class) ? CommodityCategory.find_by_name(gi.commodity_class).id : ''
           project_id = Project.find_by_project_code(gi.project_code).id
        begin
          if (gin.nil?)

            operation = Operation.find_by(year: '2008', round: gi.round[0], program_id: 1)
            gin = Dispatch.new(
                gin_no: gi.gin,
            
                requisition_number: gi.requisition_no,
                dispatch_date: gi.dispatch_date,
                fdp_id: fdp_id,
                transporter_id: transporter_id,
                plate_number: gi.plat_no,
                trailer_plate_number: gi.trailer_no,
                drivers_name: gi.driver,
                storekeeper_name: gi.storekeeper ? gi.storekeeper : 'unknown',
                remark: gi.remark,
                draft: true
            )
            else 
                gin.draft = true  
            end

            #if gin is saved check if this is another dispatch_item with a different commodity_id
            if !gin.dispatch_items.where(commodity_id: commodity_id, quantity: gi.mt_dispatched,project_id: project_id).empty?

                log.info "This record (#{gi.id}) seems to be a duplicate of dispatch record #{gin.id}"
                log.info "gin: #{gin.gin_no} , commodity_id:#{commodity_id}"
            else
              gin.dispatch_items.build(
                                       commodity_category_id: commodity_cat_id,
                                       commodity_id: commodity_id,
                                       quantity: gi.mt_dispatched,
                                       project_id: project_id
              )
              gin.save!


            end
           success += 1
           gi.imported = true
           gi.save!
          
           log.info "git_import id  #{gi.id}  saved as gin #{ gin.id}"
           log.info "Updated #{success} gin record(s)"

         rescue Exception => e
           fail += 1
           failed_rows += ",#{gi.id}"
           gi.imported = false
           gi.save

           log.info "Exception while trying to save git_import, id: #{gi.id}"
           log.info 'Cause: '+ e.message
           log.info e.backtrace.join("\n")

         end


        log.info "------------------//-------------------------"
      end
      log.info "Copied #{success} git_import records successfully."
      log.info "Failed records: #{fail}"
      log.info "Failed rows \n #{ failed_rows }"

      end_time = Time.now
      duration = (end_time - start_time ) / 1.minute
      log.info "Task finished at #{end_time} and lasted #{duration} minutes."
      log.close
    end

    desc "update dispatch_date date field of imported dispatches"
    # This task is used to update dispatch_date fields that were incorrectly imported from the gin_imports table. 
    # The dates on gin_import table are in Ethiopian calendar and have different formats.
    # This is to keep an additional string field for the imported date fields and later filter and update them 
    # by converting to a Gregorian date.
    task update_dates: :environment do
      log = ActiveSupport::Logger.new('log/update_dispatched_date.log')
      start_time = Time.now
      log.info "Started updating dispatch_date in dispatches at #{start_time}"
     
      success = 0
      fail = 0
      failed_rows = ''
     
      receipts_with_wrong_dates = Dispatch.where(:gin_no => GitImport.all.pluck(:gin))
      receipts_with_wrong_dates.all.each do |d|

      begin
          git_import = GitImport.find_by_gin(d.gin_no)
          d.dispatch_date = DateTime.now
          d.dispatched_date_ec = git_import.dispatch_date
          success += 1            
          d.save!        
          log.info "updated #{success} gin_import records"
      rescue Exception => e
          
          fail += 1
          failed_rows += ",#{d.id}"
            
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


