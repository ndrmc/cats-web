namespace :cats do
  namespace :gin do
    desc "Migrates git_imports table from the excel entry into dispatches table"
    task import: :environment do
      Rails.logger.info "Started reading git_import records."
      success = 0
      fail = 0
      failed_rows = ''
      GitImport.all.each do |gi|
        Rails.logger.info "------------------#{gi.id}-------------------------"

           transporter_id = Transporter.find_by_name(gi.transporter) ? Transporter.find_by_name(gi.transporter).id : nil
           fdp_id = Fdp.find_by_name(gi.fdp).id
           gin = Dispatch.find_by_gin_no(gi.gin)
           commodity_id = Commodity.find_by_name(gi.commodity_type).id
           commodity_cat_id = CommodityCategory.find_by_name(gi.commodity_class).id
           project_id = Project.find_by_project_code(gi.project_code).id
        begin
          if (gin.nil?)

            operation_id = Operation.where(year: '2016', round: gi.round, program_id: 1)
            gin = Dispatch.new(
                gin_no: gi.gin,
                operation_id: operation_id,
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


            end
            items_dup = gin.dispatch_items.where(commodity_id: commodity_id, quantity: gi.mt_dispatched,project_id: project_id)
           Rails.logger.info items_dup
            #if gin is saved check if this is another dispatch_item with a different commodity_id
            if !gin.dispatch_items.where(commodity_id: commodity_id, quantity: gi.mt_dispatched,project_id: project_id).empty?

                Rails.logger.info "This record (#{gi.id}) seems to be a duplicate of dispatch record #{gin.id}"
                Rails.logger.info "gin: #{gin.gin_no} , commodity_id:#{commodity_id}"
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
           Rails.logger.info "git_import id  #{gi.id}  saved as gin #{ gin.id}"
           Rails.logger.info "Updated #{success} gin record(s)"
         rescue Exception => e
           fail += 1
           failed_rows += ",#{gi.id}"
           Rails.logger.info "Exception while trying to save git_import, id: #{gi.id}"
           Rails.logger.info 'Cause: '+ e.message
           Rails.logger.info e.backtrace.join("\n")
         end


        Rails.logger.info "------------------//-------------------------"
      end
      Rails.logger.info "Copied #{success} git_import records successfully."
      Rails.logger.info "Failed records: #{fail}"
      Rails.logger.info "Failed rows \n #{ failed_rows }"
  end
  end
end


