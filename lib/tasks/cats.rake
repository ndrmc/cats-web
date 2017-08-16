require 'terminal-table'

namespace :cats do
    namespace :migrate do
      desc "Migrates adminunit records from v1 database to refactored location hierarchy based on ancestry gem path-enumeration pattern"
      task location: :environment do
      puts "Started migration of AdminUnit records"

      table = Terminal::Table.new :headings=> ['Step','Total records', 'Migrated records', 'Failed records']

      updated = 0
      # Iterate over all records and update parent_id field with parent_node_id
      # TOTO: update admin_unit type betweeen AdminUnit and Locaiton table
      Location.all.each do |l|
        l.parent_id = l.parent_node_id
        l.save
        updated += 1
      end

      rows = []
      rows << ['AdminUnit', Location.count,updated, Location.count - updated]
      rows << ['Location', Location.count, updated, Location.count - updated]

      table.rows = rows
      puts table

      puts "Completed migration of AdminUnit records to Location hierarchy"
     end
    end
    namespace :fdp do
      desc "Updates region, zone and woreda fields for all FDPs"
      task update_locations: :environment do
        puts "Started update ..."

        # Iterate over all records and save again (triggers before_save method and updates the fields)
        Fdp.all.each do |l|
          l.save
        end



        puts "Completed update"
      end
    end
    namespace :commodities do
      desc "insert commodity records under their category"
      task update: :environment do
        puts "Started updating commodities"

        machine = CommodityCategory.find_by_name('Machine')

        #FOOD ITEMS
        uom_category = UomCategory.find_by(name: 'weight')

        cereal = CommodityCategory.find_by(code: 'cereal')
        commodities = Commodity.where(:name => ['Cereal','Grain','Maize ','Rice','Sorghum','Wheat'])
        commodities.each do |c|
          c.commodity_category_id = cereal.id
          c.uom_category_id = uom_category.id
          c.save!
        end

        pulse = CommodityCategory.find_by(code: 'pulse')
        commodities = Commodity.where(:name => ['Pulse','Red Haricot Beans','White Haricot Beans','Beans','Lentils','Split Lentils','Peas','Yellow Split Peas'])
        commodities.each do |c|
          c.commodity_category_id = pulse.id
          c.uom_category_id = uom_category.id
          c.save!
        end

        blendedfood = CommodityCategory.find_by(code: 'bf')
        commodities = Commodity.where(:name => ['Blended food','CSB','CSB+','CSB++','FAMIX','Fafa Relief'])
        commodities.each do |c|
          c.commodity_category_id = blendedfood.id
          c.uom_category_id = uom_category.id
          c.save!
        end

        oil = CommodityCategory.find_by(code: 'oil')
        commodities = Commodity.where(:name => ['Oil','Vegitable Oil','Palm Oil','Olive Oil'])
        commodities.each do |c|
          c.commodity_category_id = oil.id
          c.uom_category_id = uom_category.id
          c.save!
        end

        foodsupplement = CommodityCategory.find_by(code: 'sf')
        commodities = Commodity.where(:name => ['Sup. Food','Biscuit','Dates','Wheat Flour', 'Milk'])
        commodities.each do |c|
          c.commodity_category_id = foodsupplement.id
          c.uom_category_id = uom_category.id
          c.save!
        end

        food = CommodityCategory.find_by(code: 'food')
        commodities = Commodity.where(:name => ['Other Foods'])
        commodities.each do |c|
          c.commodity_category_id = food.id
          c.uom_category_id = uom_category.id
          c.save!
        end

        cream_beans = Commodity.find_or_initialize_by(name: 'Cream Beans')
        cream_beans.commodity_category_id =  pulse.id
        cream_beans.code = 'CRB'
        cream_beans.uom_category_id = uom_category.id
        cream_beans.save!

        cream_pulse = Commodity.find_or_initialize_by(name: 'Cream Pulse' )
        cream_pulse.commodity_category_id = pulse.id
        cream_pulse.code = 'CRP'
        cream_pulse.uom_category_id = uom_category.id
        cream_pulse.save!

        soya = Commodity.find_or_initialize_by(name: 'Soya Beans')
        soya.commodity_category_id =  pulse.id
        soya.code = 'SYB'
        soya.uom_category_id = uom_category.id
        soya.save!

        mecarone = Commodity.find_or_initialize_by(name: 'Mecarone')
        mecarone.commodity_category_id = foodsupplement.id
        mecarone.code = 'MCR'
        mecarone.uom_category_id = uom_category.id
        mecarone.save!

        # NON FOOD ITEMS

        uom_category = UomCategory.find_by(name: 'unit')

        cloth = CommodityCategory.find_by(code: 'clothing')
        commodities = Commodity.where(:name => ['Clothing','Blanket','Bed Sheet','Black Blanket'])
        commodities.each do |c|
          c.commodity_category_id = cloth.id
          c.uom_category_id = uom_category.id
          c.save!
        end

        non_food = CommodityCategory.find_by(code: 'nonfood')
        commodities = Commodity.where(:name => ['Other Non-Food'])
        commodities.each do |c|
          c.commodity_category_id = non_food.id
          c.uom_category_id = uom_category.id
          c.save!
        end

        house_equipments = CommodityCategory.find_by(code: 'equipment')
        commodities = Commodity.where(:name => ['House Equipment','Cooking Pots','Ladle','Spoon','Fork','Knife','Tray','Plastic Plate','Plastic Cup','Plastic Tea Cup','Plastic Jug','Plastic Bucket','Plastic Jerry Can','Plastic Sheet','Tent'])
        commodities.each do |c|
          c.commodity_category_id = house_equipments.id
          c.uom_category_id = uom_category.id
          c.save!
        end

        commodities = Commodity.where(:name => ['Machine','Pump'])
        commodities.each do |c|
          c.commodity_category_id = machine.id
          c.uom_category_id = uom_category.id
          c.save!
        end
        
        puts "Completed update"
      end
    end
    namespace :hubs do
      task create_default_warehouse: :environment do
        puts "creating default warehousesfor each hub"
        hubs = Hub.all

        hubs.each do |h|
          main_warehouse = Warehouse.new({
                                             name: h.name+' Main Warehouse',
                                             description: 'Main Warehouse at '+h.name+' hub',
                                             hub_id: h.id,
                                             location_id: h.location_id
                                         })

          main_warehouse.save!
      end
     end
	  end
    namespace :users do
      task update_admin: :environment do
        admin = User.find_or_initialize_by(email: 'admin@cats.org')
        admin.user_types = User.user_types[:admin]
        admin.save
      end
    end
    namespace :data_import do
       task update_projects: :environment do
        mt = UnitOfMeasure.find_by_code('MT').id
        oil = Commodity.find_by_name('Vegitable Oil').id
        pulse = Commodity.find_by_name('Pulse').id
        maize = Commodity.find_by_name('Maize ').id
        cereal = Commodity.find_by_name('Cereal').id
        blended_food = Commodity.find_by_name('Blended food').id
        wheat = Commodity.find_by_name('Wheat').id
        wheat_flour = Commodity.find_by_name('Wheat Flour').id
        dates =Commodity.find_by_name('Dates').id  

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

        # for receipts
         project_20 = Project.new(
            project_code: 'EFSRA 14000mt.',
            commodity_id: wheat,
            commodity_source: purchase,
            organization_id: eth_gov,
            unit_of_measure_id: mt
          )
          project_20.save!
          puts "saved project #{project_20.project_code}"

        
          project_21 = Project.new(
              project_code: 'EGTE',
              commodity_id: pulse,
              commodity_source: purchase,
              organization_id: egte,
              unit_of_measure_id: mt
          )
          project_21.save!
          puts "saved project #{project_21.project_code}"

          project_22 = Project.new(
              project_code: 'FSCD/Wheat',
              commodity_id: wheat,
              commodity_source: loan,
              organization_id: fscd,
              unit_of_measure_id: mt
          )
          project_22.save!
          puts "saved project #{project_22.project_code}"

          project_23 = Project.new(
              project_code: 'FSRA-88-15000MTgov\'t Purchase',
              commodity_id: wheat,
              commodity_source: purchase,
              organization_id: efsra,
              unit_of_measure_id: mt
          )
          project_23.save!
          puts "saved project #{project_23.project_code}"

          project_24 = Project.new(
              project_code: 'FSRA5000MT',
              commodity_id: wheat,
              commodity_source: purchase,
              organization_id: efsra,
              unit_of_measure_id: mt
          )
          project_24.save!
          puts "saved project #{project_24.project_code}"

          project_25 = Project.new(
              project_code: 'Government Local 100mt',
              commodity_id: oil,
              commodity_source: purchase,
              organization_id: eth_gov,
              unit_of_measure_id: mt
          )
          project_25.save!
          puts "saved project #{project_25.project_code}"

          project_26 = Project.new(
              project_code: 'Government purchase 4000mt.',
              commodity_id: wheat,
              commodity_source: purchase,
              organization_id: eth_gov,
              unit_of_measure_id: mt
          )
          project_26.save!
          puts "saved project #{project_26.project_code}"

          project_27 = Project.new(
              project_code: 'Government Purchase/Union/FoodSupplement',
              commodity_id: wheat_flour,
              commodity_source: purchase,
              organization_id: eth_gov,
              unit_of_measure_id: mt
          )
          project_27.save!
          puts "saved project #{project_27.project_code}"

          project_28 = Project.new(
              project_code: 'Saudi government 100mt',
              commodity_id: dates,
              commodity_source: donation,
              organization_id: saudi,
              unit_of_measure_id: mt
          )
          project_28.save!
          puts "saved project #{project_28.project_code}"

          project_29 = Project.new(
              project_code: 'WFP 15505 Mt',
              commodity_id: oil,
              commodity_source: donation,
              organization_id: wfp,
              unit_of_measure_id: mt
          )
          project_29.save!
          puts "saved project #{project_29.project_code}"

          project_30 = Project.new(
              project_code: 'WFP 6000mt  Local',
              commodity_id: maize,
              commodity_source: donation,
              organization_id: wfp,
              unit_of_measure_id: mt
          )
          project_30.save!
          puts "saved project #{project_30.project_code}"
        
      end
    end
end

