# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Season seed values
if Season.count == 0
  Season.create([
    {name: "Belg"},
    {name: "Meher"}
    ])
  puts "Created seed data for Season records"
end

# Unit of measure categories
if UomCategory.count == 0
  UomCategory.create(name: "weight") # represents weight measured commodities (cereal, csb, oil ...)
  UomCategory.create(name: "volume") # for NFIs such as water tankers, tents ...
  UomCategory.create(name: "length")
  UomCategory.create(name: "time")
  UomCategory.create(name: "unit") # NFIs such as bucket, pans, blanket ...
  puts "Created seed data for UomCategory records"
end

# Default unit of measures
if UnitOfMeasure.count == 0
  weight = UomCategory.find_by(name: "weight")
  UnitOfMeasure.create(name: 'kg', code: 'KG', description: 'Killogram', uom_type: :ref, ratio: BigDecimal.new('1.0'), uom_category: weight)
  UnitOfMeasure.create(name: 'qtl', code: 'QTL', description: 'Quintal', uom_type: :big, ratio: BigDecimal.new('100.0'), uom_category: weight)
  UnitOfMeasure.create(name: 'mt', code: 'MT', description: 'Metric ton', uom_type: :big, ratio: BigDecimal.new('1000.0'), uom_category: weight)
  UnitOfMeasure.create(name: 'bag50kg', code: 'BAG50', description: 'Bag of 50kg', uom_type: :big, ratio: BigDecimal.new('50.0'), uom_category: weight)
  UnitOfMeasure.create(name: 'bag25Kg', code: 'BAG25', description: 'Bag of 25kg', uom_type: :big, ratio: BigDecimal.new('25.0'), uom_category: weight)

  unit_category = UomCategory.find_by(name: 'unit')
  UnitOfMeasure.create(name: 'unit', code: 'UNIT', description: 'Single item', uom_type: :ref, ratio: BigDecimal.new('1.0'), uom_category: unit_category)
  UnitOfMeasure.create(name: 'dozen', code: 'DOZEN', description: 'A set of 12 items', uom_type: :big, ratio: BigDecimal.new('12.0'), uom_category: unit_category)
  UnitOfMeasure.create(name: 'gross', code: 'GROSS', description: 'A set of 144 items', uom_type: :big, ratio: BigDecimal.new('144.0'), uom_category: unit_category)

  puts "Created seed data for UnitOfMeasure records"

end

# Commodity categories
if CommodityCategory.count == 0
  weight = UomCategory.find_by(name: 'weight')
  unit = UomCategory.find_by(name: 'unit')

  CommodityCategory.create(name: 'Food', code: 'food', uom_category: weight)
  food = CommodityCategory.find_by(code: 'food', uom_category: weight)
  CommodityCategory.create(name: 'Creal', code: 'cereal', parent: food, uom_category: weight)
  CommodityCategory.create(name: 'Pulse', code: 'pulse', parent: food, uom_category: weight)
  CommodityCategory.create(name: 'Blended Food', code: 'bf', parent: food, uom_category: weight)
  CommodityCategory.create(name: 'Oil', code: 'oil', parent: food, uom_category: weight)
  CommodityCategory.create(name: 'Supplementary Food', code: 'sf', parent: food, uom_category: weight)
  CommodityCategory.create(name: 'Other', code: 'other', parent: food, uom_category: weight)

  non_food = CommodityCategory.find_by(code: 'nonfood')
  CommodityCategory.create(name: 'Cloting', code: 'clothing', uom_category: unit)
  CommodityCategory.create(name: 'House Equipment', code: 'equipment', parent: non_food,uom_category: unit)

  puts "Created seed data for CommodityCategory records"
end

# Commodities
if Commodity.count == 0

  #FOOD ITEMS
  mt = UnitOfMeasure.find_by(code: 'MT')
  cereal = CommodityCategory.find_by(code: 'cereal')
  Commodity.create(name: 'Maize', code: 'MAZ', commodity_category: cereal)
  Commodity.create(name: 'Rice', code: 'RIC', commodity_category: cereal)
  Commodity.create(name: 'Sorghum', code: 'SRM', commodity_category: cereal)
  Commodity.create(name: 'Wheat', code: 'WHT', commodity_category: cereal)

  pulse = CommodityCategory.find_by(code: 'pulse')
  Commodity.create(name: 'Red Haricot Beans', code: 'RHB', commodity_category: pulse)
  Commodity.create(name: 'White Haricot Beans', code: 'WHB', commodity_category: pulse)
  Commodity.create(name: 'Beans', code: 'BNS', commodity_category: pulse)
  Commodity.create(name: 'Lentils', code: 'LNT', commodity_category: pulse)
  Commodity.create(name: 'Split Lentils', code: 'SLNT', commodity_category: pulse)
  Commodity.create(name: 'Peas', code: 'PES', commodity_category: pulse)
  Commodity.create(name: 'Yello Split Peas', code: 'YSP', commodity_category: pulse)

  blendedfood = CommodityCategory.find_by(code: 'bf')
  Commodity.create(name: 'Corn soy blends(CSB)', code: 'CSB', commodity_category: blendedfood)
  Commodity.create(name: 'Corn soy blends (CSB+)', code: 'CSB+', commodity_category: blendedfood)
  Commodity.create(name: 'Corn soy blends (CSB++)', code: 'CSB++', commodity_category: blendedfood)
  Commodity.create(name: 'FAMIX', code: 'FMX', commodity_category: blendedfood)

  oil = CommodityCategory.find_by(code: 'oil')
  Commodity.create(name: 'Vegetable Oil', code: 'VO', commodity_category: oil)

  foodsupplement = CommodityCategory.find_by(code: 'sf')
  Commodity.create(name: 'Biscuit', code: 'BSC', commodity_category: foodsupplement)
  Commodity.create(name: 'Dates', code: 'DAT', commodity_category: foodsupplement)
  Commodity.create(name: 'Wheat Flour', code: 'WFR', commodity_category: foodsupplement)

  # NON FOOD ITEMS
  unit = UnitOfMeasure.find_by(code: 'UNIT')

  cloth = CommodityCategory.find_by(code: 'clothing')
  Commodity.create(name: 'Blanket', code: 'BKT', commodity_category: cloth)
  Commodity.create(name: 'Bed Sheet', code: 'BST', commodity_category: cloth)

  house_equipments = CommodityCategory.find_by(code: 'equipment')
  Commodity.create(name: 'Cooking pots', code: 'PTS', commodity_category: house_equipments)
  Commodity.create(name: 'Ladle', code: 'LDL', commodity_category: house_equipments)
  Commodity.create(name: 'Spoon', code: 'SPN', commodity_category: house_equipments)
  Commodity.create(name: 'Fork', code: 'FRK', commodity_category: house_equipments)
  Commodity.create(name: 'Knife', code: 'KNF', commodity_category: house_equipments)
  Commodity.create(name: 'Tray', code: 'TRY', commodity_category: house_equipments)
  Commodity.create(name: 'Plastic plate', code: 'PLP', commodity_category: house_equipments)
  Commodity.create(name: 'Plastic cup', code: 'PLC', commodity_category: house_equipments)
  Commodity.create(name: 'Plastic tea cup', code: 'PTC', commodity_category: house_equipments)
  Commodity.create(name: 'Plastic jug', code: 'PJG', commodity_category: house_equipments)
  Commodity.create(name: 'Plastic bucket', code: 'PBT', commodity_category: house_equipments)
  Commodity.create(name: 'Plastic jerry can', code: 'PJC', commodity_category: house_equipments)
  Commodity.create(name: 'Plastic sheet (4x5),(3x7),(30.5x7.3)', code: 'PST', commodity_category: house_equipments)
  Commodity.create(name: 'Tent (4x3),(4x4),(4x6),(10x6)', code: 'TNT', commodity_category: house_equipments)

  puts "Created seed data for Commodity records"
end

# Mode of Transport
if ModeOfTransport.count == 0
  ModeOfTransport.create(name: 'Ship')
  ModeOfTransport.create(name: 'Air')
  ModeOfTransport.create(name: 'Land(Truck)')
  ModeOfTransport.create(name: 'Land(Train)')

  puts "Created seed data for Mode of transport"
end

# Fund sources
if FundSource.count == 0
  FundSource.create(name: 'Donation')
  FundSource.create(name: 'Loan')
  FundSource.create(name: 'Treasury')

  puts "Created seed data for Fund source"
end

# Fund type
if FundType.count == 0
  FundType.create(name: 'Regular')
  FundType.create(name: 'Capital')

  puts "Created seed data for Fund type"
end

# Currency
if Currency.count == 0
  Currency.create(name: 'Ethiopian Birr', symbol: 'ETB')
  Currency.create(name: 'US Dollar', symbol: 'USD')
  Currency.create(name: 'Euro', symbol: 'EUR')
  Currency.create(name: 'Japanese Yen', symbol: 'JPY')
  Currency.create(name: 'Saudi Riyal', symbol: 'SAR')
  Currency.create(name: 'Chinese Yuan', symbol: 'CNY')

  puts "Created seed data for Currency"
end

# Program
if Program.count == 0
  Program.create(name: 'Relief', code: 'EM')
  Program.create(name: 'PSNP', code: 'SF')
  Program.create(name: 'IDP', code: 'IDP')

  puts "Created seed data for Program"
end

if Account.count == 0
  Account.create(name: 'Borrowed', code: :borrowed, description: 'Resources which are borrowed, but have not yet been received at warehouses (Receipt Plan)')
  Account.create(name: 'Purchased', code: :purchased, description: 'Resources which are purchased but have not yet been received at warehouses (Receipt Plan)')
  Account.create(name: 'Pledged', code: :pledged, description: 'Resources which are donated but have not yet been received at warehouses (Receipt Plan)')
  Account.create(name: 'Allocated', code: :allocated, description: 'Resources commited for dispatch through RRD. In CATS this indicates dispatch allocation')
  Account.create(name: 'Received', code: :received, description: 'Represents resources which are received at the hubs. This account represents Goods Receiving Note (GRN)')
  Account.create(name: 'Dispatched', code: :dispatched, description: 'Commodities which are dispatched from the warehouse to FDPs. This account represents Goods Issue Ticket (GIT) records.')
  Account.create(name: 'Delivered', code: :delivered, description: 'Commodities which are received at FDPs. This is equivallent to delivery note (GRN) at FDPs.')
  Account.create(name: 'Lost', code: :lost, description: 'Commodities which had proper record in the system but are not being accounted. This account is used during Delivery, Annual Inventory or Distribution.')
  Account.create(name: 'Stock', code: :stock, description: 'Amount of commodities available at the warehouses')
  Account.create(name: 'Distributed', code: :distributed, description: 'Commodities which are distributed to beneficiareis.This account represents distribution reports from CMPM')
  Account.create(name: 'Repaid', code: :repaid, description: 'Commodities which were paid back for a loan made previously.')
  Account.create(name: 'Statistics', code: :statistics, description: 'This account contains entries made when commodities are taken into (Beginning Inventory, Donation, Purchase and Loan) and released (Utilization) from the system. Similar to "cash book" account.')

  puts "Created seed data for Account records"

end

if Journal.count == 0
  Journal.create(name: 'Beginning Inventory', code: :beginning_inventory, description: '')
  Journal.create(name: 'Donation', code: :donation, description: '')
  Journal.create(name: 'Good Received', code: :goods_received, description: '')
  Journal.create(name: 'Purchase', code: :purchase, description: '')
  Journal.create(name: 'Dispatch Allocation', code: :dispatch_allocation, description: '')
  Journal.create(name: 'Goods Issue', code: :goods_issue, description: '')
  Journal.create(name: 'Loan', code: :loan, description: '')
  Journal.create(name: 'Repayment', code: :repayment, description: '')
  Journal.create(name: 'Transfer', code: :transfer, description: '')
  Journal.create(name: 'Annual Inventory', code: :annual_inventory, description: '')
  Journal.create(name: 'Delivery', code: :delivery, description: '')
  Journal.create(name: 'Distribution', code: :distribution, description: '')

  puts "Created seed data for Journal records"

end


if User.count == 0
  User.create(first_name: 'Administrator', email: 'admin@cats.org', password: 'password')
  puts "Created default user account 'admin@cats.org' with password 'password'"
end

if Role.count == 0
  [:admin, :guest, :clerk, :manager, :'Early warning', :Logistics, :FSCD, :Procurement, :Finance, :Hub, :Region].each do |role|
    Role.create(name: role)      
  end
  puts "Created default roles"
end

if RoleType.count==0
  RoleType.create(name: 'Admin', description: '')
  RoleType.create(name: 'Case Team', description: '')
  RoleType.create(name: 'Hubs', description: '')
  RoleType.create(name: 'Regional', description: '')
  puts "Created default role types"
end

if CaseTeam.count==0

  caseTeam = RoleType.find_by(name: 'Case Team')

  CaseTeam.create(name: 'Early warning', role_type: caseTeam)
  CaseTeam.create(name: 'FSCD')
  CaseTeam.create(name: 'Logistics', role_type: caseTeam)
  CaseTeam.create(name: 'Procurement', role_type: caseTeam)
  CaseTeam.create(name: 'Finance', role_type: caseTeam)

  hub = RoleType.find_by(name: 'Hubs')

  CaseTeam.create(name: 'Adama', role_type: hub)
  CaseTeam.create(name: 'Dire Dawa' , role_type: hub)
  CaseTeam.create(name: 'Kombolcha' , role_type: hub)
  CaseTeam.create(name: 'Mekele' , role_type: hub)

 region = RoleType.find_by(name: 'Regional')


  CaseTeam.create(name: 'Afar', role_type: region)
  CaseTeam.create(name: 'Amhara', role_type: region)
  CaseTeam.create(name: 'Tigray', role_type: region)
  CaseTeam.create(name: 'Oromia', role_type: region)
  CaseTeam.create(name: 'Benshangule', role_type: region)
  CaseTeam.create(name: 'SNNPR', role_type: region)
  CaseTeam.create(name: 'Gambella', role_type: region)
  CaseTeam.create(name: 'Dire Dawa', role_type: region)
  CaseTeam.create(name: 'Harari', role_type: region)
  CaseTeam.create(name: 'Somalia', role_type: region)

  puts "Created list of roles"
end
