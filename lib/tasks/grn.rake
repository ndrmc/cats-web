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

     task update_projects: :environment do
      mt = UnitOfMeasure.find_by_code('MT').id

      oil = Commodity.find_by_name('Vegitable Oil').id
      pulse = Commodity.find_by_name('Pulse').id
      maize = Commodity.find_by_name('Maize ').id
      dates =Commodity.find_by_name('Dates').id    
      wheat = Commodity.find_by_name('Wheat').id
      wheat_flour = Commodity.find_by_name('Wheat Flour').id

      purchase = Project.commodity_sources[:Purchase]
      loan = Project.commodity_sources[:Loan]
      donation = Project.commodity_sources[:Donation]

      eth_gov = Organization.find_by_name('Government of ET').id
      efsra = Organization.find_by_name('EFSRA').id
      wfp = Organization.find_by_name('UN - World Food Program').id
      fscd = Organization.find_by_name('FSCD').id
      egte = Organization.find_by_name('EGTE').id
      saudi = Organization.find_by_name('Saudi Government').id


      project_1 = Project.new(
        project_code: 'EFSRA 14000mt.',
        commodity_id: wheat,
        commodity_source: purchase,
        organization_id: eth_gov,
        unit_of_measure_id: mt
      )
      project_1.save!
      puts "saved project #{project_1.project_code}"

     
      project_3 = Project.new(
          project_code: 'EGTE',
          commodity_id: pulse,
          commodity_source: purchase,
          organization_id: egte,
          unit_of_measure_id: mt
      )
      project_3.save!
      puts "saved project #{project_3.project_code}"

      project_4 = Project.new(
          project_code: 'FSCD/Wheat',
          commodity_id: wheat,
          commodity_source: loan,
          organization_id: fscd,
          unit_of_measure_id: mt
      )
      project_4.save!
      puts "saved project #{project_4.project_code}"

      project_5 = Project.new(
          project_code: 'FSRA-88-15000MTgov\'t Purchase',
          commodity_id: wheat,
          commodity_source: purchase,
          organization_id: efsra,
          unit_of_measure_id: mt
      )
      project_5.save!
      puts "saved project #{project_5.project_code}"

      project_6 = Project.new(
          project_code: 'FSRA5000MT',
          commodity_id: wheat,
          commodity_source: purchase,
          organization_id: efsra,
          unit_of_measure_id: mt
      )
      project_6.save!
      puts "saved project #{project_6.project_code}"

      project_7 = Project.new(
          project_code: 'Government Local 100mt',
          commodity_id: oil,
          commodity_source: purchase,
          organization_id: eth_gov,
          unit_of_measure_id: mt
      )
      project_7.save!
      puts "saved project #{project_7.project_code}"

      project_8 = Project.new(
          project_code: 'Government purchase 4000mt.',
          commodity_id: wheat,
          commodity_source: purchase,
          organization_id: eth_gov,
          unit_of_measure_id: mt
      )
      project_8.save!
      puts "saved project #{project_8.project_code}"

      project_9 = Project.new(
          project_code: 'Government Purchase/Union/FoodSupplement',
          commodity_id: wheat_flour,
          commodity_source: purchase,
          organization_id: eth_gov,
          unit_of_measure_id: mt
      )
      project_9.save!
      puts "saved project #{project_9.project_code}"

      project_10 = Project.new(
          project_code: 'Saudi government 100mt',
          commodity_id: dates,
          commodity_source: donation,
          organization_id: saudi,
          unit_of_measure_id: mt
      )
      project_10.save!
      puts "saved project #{project_10.project_code}"

      project_11 = Project.new(
          project_code: 'WFP 15505 Mt',
          commodity_id: oil,
          commodity_source: donation,
          organization_id: wfp,
          unit_of_measure_id: mt
      )
      project_11.save!
      puts "saved project #{project_11.project_code}"

      project_12 = Project.new(
          project_code: 'WFP 6000mt  Local',
          commodity_id: maize,
          commodity_source: donation,
          organization_id: wfp,
          unit_of_measure_id: mt
      )
      project_12.save!
      puts "saved project #{project_12.project_code}"
     
    end

  end
end


