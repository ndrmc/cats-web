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

    task update_projects: :environment do
      mt = UnitOfMeasure.find_by_code('MT').id
      oil = Commodity.find_by_name('Vegitable Oil').id
      pulse = Commodity.find_by_name('Pulse').id
      maize = Commodity.find_by_name('Maize ').id
      cereal = Commodity.find_by_name('Cereal').id
      blended_food = Commodity.find_by_name('Blended food').id
      wheat = Commodity.find_by_name('Wheat').id
      purchase = Project.commodity_sources[:Purchase]
      loan = Project.commodity_sources[:Loan]

      eth_gov = Organization.find_by_name('Government of ET').id
      efsra = Organization.find_by_name('EFSRA').id
      wfp = Organization.find_by_name('UN - World Food Program').id
      fscd = Organization.find_by_name('FSCD').id


      project_1 = Project.new(
        project_code: 'Government Purchase/Pulse',
        commodity_id: pulse,
        commodity_source: purchase,
        organization_id: eth_gov,
        unit_of_measure_id: mt
      )
      project_1.save!
      puts "saved project #{project_1.project_code}"

      project_2 = Project.new(
          project_code: 'EFSRA/Maize',
          commodity_id: maize,
          commodity_source: purchase,
          organization_id: efsra,
          unit_of_measure_id: mt
      )
      project_2.save!
      puts "saved project #{project_2.project_code}"

      project_3 = Project.new(
          project_code: 'FSCD/Maize',
          commodity_id: maize,
          commodity_source: purchase,
          organization_id: fscd,
          unit_of_measure_id: mt
      )
      project_3.save!
      puts "saved project #{project_3.project_code}"

      project_4 = Project.new(
          project_code: 'Government Purchase/Union/Pulse',
          commodity_id: pulse,
          commodity_source: purchase,
          organization_id: eth_gov,
          unit_of_measure_id: mt
      )
      project_4.save!
      puts "saved project #{project_4.project_code}"

      project_5 = Project.new(
          project_code: 'Government Purchase/Union/VOil',
          commodity_id: oil,
          commodity_source: purchase,
          organization_id: eth_gov,
          unit_of_measure_id: mt
      )
      project_5.save!
      puts "saved project #{project_5.project_code}"

      project_6 = Project.new(
          project_code: 'Government Purchase/Cereal',
          commodity_id: cereal,
          commodity_source: purchase,
          organization_id: eth_gov,
          unit_of_measure_id: mt
      )
      project_6.save!
      puts "saved project #{project_6.project_code}"

      project_7 = Project.new(
          project_code: 'Government Purchase/BlendedFood',
          commodity_id: blended_food,
          commodity_source: purchase,
          organization_id: eth_gov,
          unit_of_measure_id: mt
      )
      project_7.save!
      puts "saved project #{project_7.project_code}"

      project_8 = Project.new(
          project_code: 'Government Purchase/VOil',
          commodity_id: oil,
          commodity_source: purchase,
          organization_id: eth_gov,
          unit_of_measure_id: mt
      )
      project_8.save!
      puts "saved project #{project_8.project_code}"

      project_9 = Project.new(
          project_code: 'WFP-25000',
          commodity_id: wheat,
          commodity_source: loan,
          organization_id: wfp,
          unit_of_measure_id: mt
      )
      project_9.save!
      puts "saved project #{project_9.project_code}"

      project_10 = Project.new(
          project_code: 'WFP/Pulse',
          commodity_id: pulse,
          commodity_source: loan,
          organization_id: wfp,
          unit_of_measure_id: mt
      )
      project_10.save!
      puts "saved project #{project_10.project_code}"

      project_11 = Project.new(
          project_code: 'WFP/Cereal',
          commodity_id: cereal,
          commodity_source: loan,
          organization_id: wfp,
          unit_of_measure_id: mt
      )
      project_11.save!
      puts "saved project #{project_11.project_code}"

      project_12 = Project.new(
          project_code: 'WFP/VOil',
          commodity_id: oil,
          commodity_source: loan,
          organization_id: wfp,
          unit_of_measure_id: mt
      )
      project_12.save!
      puts "saved project #{project_12.project_code}"

      project_13 = Project.new(
          project_code: 'DRMFSS Purchase/Pulse',
          commodity_id: pulse,
          commodity_source: purchase,
          organization_id: eth_gov,
          unit_of_measure_id: mt
      )
      project_13.save!
      puts "saved project #{project_13.project_code}"

      project_14 = Project.new(
          project_code: 'DRMFSS Purchase/BlendedFood',
          commodity_id: blended_food,
          commodity_source: purchase,
          organization_id: eth_gov,
          unit_of_measure_id: mt
      )
      project_14.save!
      puts "saved project #{project_14.project_code}"

      project_15 = Project.new(
          project_code: 'DRMFSS Purchase/Wheat',
          commodity_id: wheat,
          commodity_source: purchase,
          organization_id: eth_gov,
          unit_of_measure_id: mt
      )
      project_15.save!
      puts "saved project #{project_15.project_code}"

      project_16 = Project.new(
          project_code: 'EFSRA/Wheat',
          commodity_id: wheat,
          commodity_source: purchase,
          organization_id: efsra,
          unit_of_measure_id: mt
      )
      project_16.save!
      puts "saved project #{project_16.project_code}"

      project_17 = Project.new(
          project_code: 'Government Purchase/Union/Cereal',
          commodity_id: cereal,
          commodity_source: purchase,
          organization_id: eth_gov,
          unit_of_measure_id: mt
      )
      project_17.save!
      puts "saved project #{project_17.project_code}"

      project_18 = Project.new(
          project_code: 'DRMFSS Purchase 11459 Mt. ',
          commodity_id: oil,
          commodity_source: purchase,
          organization_id: eth_gov,
          unit_of_measure_id: mt
      )
      project_18.save!
      puts "saved project #{project_18.project_code}"

      project_19 = Project.new(
          project_code: 'EFSRA 6000 MT',
          commodity_id: oil,
          commodity_source: purchase,
          organization_id: efsra,
          unit_of_measure_id: mt
      )
      project_19.save!
      puts "saved project #{project_19.project_code}"
    end
  end
end


