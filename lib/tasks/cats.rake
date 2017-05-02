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
end

