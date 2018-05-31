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

weight = UomCategory.find_by(name: 'weight')
unit = UomCategory.find_by(name: 'unit')
non_food = CommodityCategory.find_or_initialize_by(name: 'Non Food', code: 'nonfood', uom_category: weight)
non_food.save!

machine = CommodityCategory.find_or_initialize_by(name: 'Machine', code: 'machine', uom_category: unit)
machine.parent = non_food
machine.save!

if CommodityCategory.count == 0

  CommodityCategory.create(name: 'Food', code: 'food', uom_category: weight)

  food = CommodityCategory.find_by(code: 'food', uom_category: weight)
  CommodityCategory.create(name: 'Cereal', code: 'cereal', parent: food, uom_category: weight)
  CommodityCategory.create(name: 'Pulse', code: 'pulse', parent: food, uom_category: weight)
  CommodityCategory.create(name: 'Blended Food', code: 'bf', parent: food, uom_category: weight)
  CommodityCategory.create(name: 'Oil', code: 'oil', parent: food, uom_category: weight)
  CommodityCategory.create(name: 'Supplementary Food', code: 'sf', parent: food, uom_category: weight)
  CommodityCategory.create(name: 'Other', code: 'other', parent: food, uom_category: weight)

  non_food = CommodityCategory.find_by(code: 'nonfood')
  CommodityCategory.create(name: 'Clothing', code: 'clothing', uom_category: unit)
  CommodityCategory.create(name: 'House Equipment', code: 'equipment', parent: non_food,uom_category: unit)

  puts "Created seed data for CommodityCategory records"
end

# Commodities



#puts "Created seed data for Commodity records"




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
  #Account.create(name: 'Borrowed', code: :borrowed, description: 'Resources which are borrowed, but have not yet been received at warehouses (Receipt Plan)')
  #Account.create(name: 'Purchased', code: :purchased, description: 'Resources which are purchased but have not yet been received at warehouses (Receipt Plan)')
  #Account.create(name: 'Pledged', code: :pledged, description: 'Resources which are donated but have not yet been received at warehouses (Receipt Plan)')
  Account.create(name: 'Receivable', code: :receivable, description: 'Resources which are either donated,purchased or borrowed but have not yet been received at warehouses (Receipt Plan)')
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
  User.create(first_name: 'Administrator', email: 'admin@cats.org', password: 'password', user_types: User.user_types[:admin] )
  puts "Created default user account 'admin@cats.org' with password 'password'"
end

if Role.count == 0
  [:hub, :federal, :region].each do |role|
    Role.create(name: role)
  end
  puts "Created default roles"
end

if UserType.count==0
  UserType.create(name: 'admin', description: '')
  UserType.create(name: 'federal', description: '')
  UserType.create(name: 'hub', description: '')
  UserType.create(name: 'region', description: '')
  puts "Created default User types"
end

if OwnershipType.count == 0
  OwnershipType.create(name: 'private', description: '')
  OwnershipType.create(name: 'plc', description: '')
  OwnershipType.create(name: 'share company', description: '')
  OwnershipType.create(name: 'government', description: '')
  OwnershipType.create(name: 'ngo', description: '')
  OwnershipType.create(name: 'other', description: '')
  puts "Created ownership types lookup"
end

if Permission.count == 0 
  
  Permission.create(name: 'HRD', description: '')
  Permission.create(name: 'Gift Certificate', description: '')
  Permission.create(name: 'Receipts', description: '')
  Permission.create(name: 'Receipt Plan', description: '')
  Permission.create(name: 'Bid Plan', description: '')
  Permission.create(name: 'Project', description: '')
  Permission.create(name: 'Ration', description: '')

  Permission.create(name: 'Dispatch', description: '')
  Permission.create(name: 'Need Assessment', description: '')
  Permission.create(name: 'Commodity', description: '')
  Permission.create(name: 'Warehouses', description: '')
  Permission.create(name: 'PSNP Annual Plan', description: '')

  Permission.create(name: 'Delivery', description: '')
  Permission.create(name: 'Transfers', description: '')
  Permission.create(name: 'Donor', description: '')
  Permission.create(name: 'Organizations', description: '')
  Permission.create(name: 'Unit of Measurements', description: '')
 
  Permission.create(name: 'Operation', description: '')
  Permission.create(name: 'Currencies', description: '')
  Permission.create(name: 'FDP', description: '')
  Permission.create(name: 'locations', description: '')
  Permission.create(name: 'Programs', description: '')

  Permission.create(name: 'Regional Requests', description: '')
  Permission.create(name: 'Requisition', description: '')
  Permission.create(name: 'Settings', description: '')
  Permission.create(name: 'Transporters', description: '')
  Permission.create(name: 'StockTakes', description: '')

  puts "Permissions created"

end

if Permission.where(name: 'FrameworkTender').count == 0
  Permission.create(name: 'FrameworkTender', user_type: 0, description: '')
  Permission.create(name: 'FrameworkTender', user_type: 1, description: '')
  Permission.create(name: 'FrameworkTender', user_type: 2, description: '')
  Permission.create(name: 'FrameworkTender', user_type: 3, description: '')
end

if Permission.where(name: 'Bid').count == 0
  Permission.create(name: 'Bid', user_type: 0, description: '')
  Permission.create(name: 'Bid', user_type: 1, description: '')
  Permission.create(name: 'Bid', user_type: 2, description: '')
  Permission.create(name: 'Bid', user_type: 3, description: '')
end

if Permission.where(name: 'BidQuotation').count == 0
  Permission.create(name: 'BidQuotation', user_type: 0, description: '')
  Permission.create(name: 'BidQuotation', user_type: 1, description: '')
  Permission.create(name: 'BidQuotation', user_type: 2, description: '')
  Permission.create(name: 'BidQuotation', user_type: 3, description: '')
end

if Permission.where(name: 'Adjustment').count == 0
  Permission.create(name: 'Adjustment', user_type: 0, description: '')
  Permission.create(name: 'Adjustment', user_type: 1, description: '')
  Permission.create(name: 'Adjustment', user_type: 2, description: '')
  Permission.create(name: 'Adjustment', user_type: 3, description: '')
end

if Permission.where(name: 'Commodity').count == 0
  Permission.create(name: 'Commodity', user_type: 0, description: '')
  Permission.create(name: 'Commodity', user_type: 1, description: '')
  Permission.create(name: 'Commodity', user_type: 2, description: '')
  Permission.create(name: 'Commodity', user_type: 3, description: '')
end

if Permission.where(name: 'CommodityCategory').count == 0
  Permission.create(name: 'CommodityCategory', user_type: 0, description: '')
  Permission.create(name: 'CommodityCategory', user_type: 1, description: '')
  Permission.create(name: 'CommodityCategory', user_type: 2, description: '')
  Permission.create(name: 'CommodityCategory', user_type: 3, description: '')
end

if Permission.where(name: 'CommoditySource').count == 0
  Permission.create(name: 'CommoditySource', user_type: 0, description: '')
  Permission.create(name: 'CommoditySource', user_type: 1, description: '')
  Permission.create(name: 'CommoditySource', user_type: 2, description: '')
  Permission.create(name: 'CommoditySource', user_type: 3, description: '')
end

if Permission.where(name: 'Contribution').count == 0
  Permission.create(name: 'Contribution', user_type: 0, description: '')
  Permission.create(name: 'Contribution', user_type: 1, description: '')
  Permission.create(name: 'Contribution', user_type: 2, description: '')
  Permission.create(name: 'Contribution', user_type: 3, description: '')
end

if Permission.where(name: 'Currency').count == 0
  Permission.create(name: 'Currency', user_type: 0, description: '')
  Permission.create(name: 'Currency', user_type: 1, description: '')
  Permission.create(name: 'Currency', user_type: 2, description: '')
  Permission.create(name: 'Currency', user_type: 3, description: '')
end

if Permission.where(name: 'Department').count == 0
  Permission.create(name: 'Department', user_type: 0, description: '')
  Permission.create(name: 'Department', user_type: 1, description: '')
  Permission.create(name: 'Department', user_type: 2, description: '')
  Permission.create(name: 'Department', user_type: 3, description: '')
end

if Permission.where(name: 'Donor').count == 0
  Permission.create(name: 'Donor', user_type: 0, description: '')
  Permission.create(name: 'Donor', user_type: 1, description: '')
  Permission.create(name: 'Donor', user_type: 2, description: '')
  Permission.create(name: 'Donor', user_type: 3, description: '')
end

if Permission.where(name: 'FdpContact').count == 0
  Permission.create(name: 'FdpContact', user_type: 0, description: '')
  Permission.create(name: 'FdpContact', user_type: 1, description: '')
  Permission.create(name: 'FdpContact', user_type: 2, description: '')
  Permission.create(name: 'FdpContact', user_type: 3, description: '')
end

if Permission.where(name: 'Fdp').count == 0
  Permission.create(name: 'Fdp', user_type: 0, description: '')
  Permission.create(name: 'Fdp', user_type: 1, description: '')
  Permission.create(name: 'Fdp', user_type: 2, description: '')
  Permission.create(name: 'Fdp', user_type: 3, description: '')
end

if Permission.where(name: 'Hub').count == 0
  Permission.create(name: 'Hub', user_type: 0, description: '')
  Permission.create(name: 'Hub', user_type: 1, description: '')
  Permission.create(name: 'Hub', user_type: 2, description: '')
  Permission.create(name: 'Hub', user_type: 3, description: '')
end

if Permission.where(name: 'Journal').count == 0
  Permission.create(name: 'Journal', user_type: 0, description: '')
  Permission.create(name: 'Journal', user_type: 1, description: '')
  Permission.create(name: 'Journal', user_type: 2, description: '')
  Permission.create(name: 'Journal', user_type: 3, description: '')
end

if Permission.where(name: 'Organization').count == 0
  Permission.create(name: 'Organization', user_type: 0, description: '')
  Permission.create(name: 'Organization', user_type: 1, description: '')
  Permission.create(name: 'Organization', user_type: 2, description: '')
  Permission.create(name: 'Organization', user_type: 3, description: '')
end

if Permission.where(name: 'Permission').count == 0
  Permission.create(name: 'Permission', user_type: 0, description: '')
  Permission.create(name: 'Permission', user_type: 1, description: '')
  Permission.create(name: 'Permission', user_type: 2, description: '')
  Permission.create(name: 'Permission', user_type: 3, description: '')
end

if Permission.where(name: 'Program').count == 0
  Permission.create(name: 'Program', user_type: 0, description: '')
  Permission.create(name: 'Program', user_type: 1, description: '')
  Permission.create(name: 'Program', user_type: 2, description: '')
  Permission.create(name: 'Program', user_type: 3, description: '')
end

if Permission.where(name: 'ProjectCodeAllocation').count == 0
  Permission.create(name: 'ProjectCodeAllocation', user_type: 0, description: '')
  Permission.create(name: 'ProjectCodeAllocation', user_type: 1, description: '')
  Permission.create(name: 'ProjectCodeAllocation', user_type: 2, description: '')
  Permission.create(name: 'ProjectCodeAllocation', user_type: 3, description: '')
end

if Permission.where(name: 'RationItem').count == 0
  Permission.create(name: 'RationItem', user_type: 0, description: '')
  Permission.create(name: 'RationItem', user_type: 1, description: '')
  Permission.create(name: 'RationItem', user_type: 2, description: '')
  Permission.create(name: 'RationItem', user_type: 3, description: '')
end

if Permission.where(name: 'RoleType').count == 0
  Permission.create(name: 'RoleType', user_type: 0, description: '')
  Permission.create(name: 'RoleType', user_type: 1, description: '')
  Permission.create(name: 'RoleType', user_type: 2, description: '')
  Permission.create(name: 'RoleType', user_type: 3, description: '')
end

if Permission.where(name: 'Role').count == 0
  Permission.create(name: 'Role', user_type: 0, description: '')
  Permission.create(name: 'Role', user_type: 1, description: '')
  Permission.create(name: 'Role', user_type: 2, description: '')
  Permission.create(name: 'Role', user_type: 3, description: '')
end

if Permission.where(name: 'StockMovement').count == 0
  Permission.create(name: 'StockMovement', user_type: 0, description: '')
  Permission.create(name: 'StockMovement', user_type: 1, description: '')
  Permission.create(name: 'StockMovement', user_type: 2, description: '')
  Permission.create(name: 'StockMovement', user_type: 3, description: '')
end

if Permission.where(name: 'StockTakeItem').count == 0
  Permission.create(name: 'StockTakeItem', user_type: 0, description: '')
  Permission.create(name: 'StockTakeItem', user_type: 1, description: '')
  Permission.create(name: 'StockTakeItem', user_type: 2, description: '')
  Permission.create(name: 'StockTakeItem', user_type: 3, description: '')
end

if Permission.where(name: 'TransportOrder').count == 0
  Permission.create(name: 'TransportOrder', user_type: 0, description: '')
  Permission.create(name: 'TransportOrder', user_type: 1, description: '')
  Permission.create(name: 'TransportOrder', user_type: 2, description: '')
  Permission.create(name: 'TransportOrder', user_type: 3, description: '')
end

if Permission.where(name: 'TransportRequisition').count == 0
  Permission.create(name: 'TransportRequisition', user_type: 0, description: '')
  Permission.create(name: 'TransportRequisition', user_type: 1, description: '')
  Permission.create(name: 'TransportRequisition', user_type: 2, description: '')
  Permission.create(name: 'TransportRequisition', user_type: 3, description: '')
end

if Permission.where(name: 'TransporterAddress').count == 0
  Permission.create(name: 'TransporterAddress', user_type: 0, description: '')
  Permission.create(name: 'TransporterAddress', user_type: 1, description: '')
  Permission.create(name: 'TransporterAddress', user_type: 2, description: '')
  Permission.create(name: 'TransporterAddress', user_type: 3, description: '')
end

if Permission.where(name: 'TransporterPayment').count == 0
  Permission.create(name: 'TransporterPayment', user_type: 0, description: '')
  Permission.create(name: 'TransporterPayment', user_type: 1, description: '')
  Permission.create(name: 'TransporterPayment', user_type: 2, description: '')
  Permission.create(name: 'TransporterPayment', user_type: 3, description: '')
end

if Permission.where(name: 'UnitOfMeasure').count == 0
  Permission.create(name: 'UnitOfMeasure', user_type: 0, description: '')
  Permission.create(name: 'UnitOfMeasure', user_type: 1, description: '')
  Permission.create(name: 'UnitOfMeasure', user_type: 2, description: '')
  Permission.create(name: 'UnitOfMeasure', user_type: 3, description: '')
end

if Permission.where(name: 'WarehouseAllocation').count == 0
  Permission.create(name: 'WarehouseAllocation', user_type: 0, description: '')
  Permission.create(name: 'WarehouseAllocation', user_type: 1, description: '')
  Permission.create(name: 'WarehouseAllocation', user_type: 2, description: '')
  Permission.create(name: 'WarehouseAllocation', user_type: 3, description: '')
end

if Permission.where(name: 'WarehouseSelection').count == 0
  Permission.create(name: 'WarehouseSelection', user_type: 0, description: '')
  Permission.create(name: 'WarehouseSelection', user_type: 1, description: '')
  Permission.create(name: 'WarehouseSelection', user_type: 2, description: '')
  Permission.create(name: 'WarehouseSelection', user_type: 3, description: '')
end


if Permission.where(name: 'Store').count == 0
  Permission.create(name: 'Store', user_type: 0, description: '')
  Permission.create(name: 'Store', user_type: 1, description: '')
  Permission.create(name: 'Store', user_type: 2, description: '')
  Permission.create(name: 'Store', user_type: 3, description: '')
end


if Permission.where(name: 'UserAccount').count == 0
  Permission.create(name: 'UserAccount', user_type: 0, description: '')
  Permission.create(name: 'UserAccount', user_type: 1, description: '')
  Permission.create(name: 'UserAccount', user_type: 2, description: '')
  Permission.create(name: 'UserAccount', user_type: 3, description: '')
end

if Department.count == 0
  Department.create(name: 'Early warning')
  Department.create(name: 'FSCD')
  Department.create(name: 'Logistics')
  Department.create(name: 'Procurement')
  Department.create(name: 'Finance')
  Department.create(name: 'Hub')
  Department.create(name: 'Regional')

  puts "Created seed data for departments"
end

if UsersPermission.count == 0 
  users  = User.find_by(first_name: 'Administrator')
  permissions = Permission.all

  permissions.each do |p|
    user_permission =  UsersPermission.new({
      user_id: users.id,
      permission_id: p.id
    })
    user_permission.save!
  end
  puts "Default permissisons for administrator created"
end


 users  = User.find_by(first_name: 'Administrator')
 permissions = Permission.where(name: 'UserAccount')
 
if permissions 
  saved = false
  user_permission_ids = UsersPermission.all.pluck(:permission_id)
  permissions.each do |p|
    if permissions.where(p.id.to_s + ' IN (?)', user_permission_ids).count < 1
    user_permission =  UsersPermission.new({
      user_id: users.id,
      permission_id: p.id
    })
    user_permission.save!
    saved = true
  end
end
  if saved
    puts "Default user permissisons for administrator created"
  end
  
end


if Supplier.count == 0
  Supplier.create(name: 'Abay International PLC')
  Supplier.create(name: 'Addis Zemen ')
  Supplier.create(name: 'Admas PLC  ')
  Supplier.create(name: 'Ambasel ')
  Supplier.create(name: 'Ambo')
  Supplier.create(name: 'Asayita')
  Supplier.create(name: 'Damot / Union')
  Supplier.create(name: 'Debre Birhan')
  Supplier.create(name: 'Debre Markos')
  Supplier.create(name: 'Dire Dawa NDRMC')
  Supplier.create(name: 'EFSRA')
  Supplier.create(name: 'Ethio.Agri. CEFT PLC.')
  Supplier.create(name: 'Ethiopian Ehel Nigde Derjit')
  Supplier.create(name: 'FAFA Food ')
  Supplier.create(name: 'Government purchase')
  Supplier.create(name: 'Gozamen F Union')
  Supplier.create(name: 'Mota')
  Supplier.create(name: 'Mota G/H/S/M')
  Supplier.create(name: 'Nazreth C/Wh')
  Supplier.create(name: 'Nazreth NDRMC')
  Supplier.create(name: 'NDRMC')
  Supplier.create(name: 'Noriva PLC')
  Supplier.create(name: 'Nur Hussen Adem')
  Supplier.create(name: 'Soreti Int. Trading')
  Supplier.create(name: 'Tena migib Amrach')
  Supplier.create(name: 'Woreta')
  Supplier.create(name: 'Woreta EFSRA')
end

o1 = Organization.find_or_initialize_by(name: "EGTE")
o1.long_name = "Ethiopian Grain Trade Enterprise"
o1.save!

o2 = Organization.find_or_initialize_by(name: "Saudi Government")
o2.long_name = "Government of Saudi Arabia"
o2.save!

if (Permission.where(:name => "Transporters").present? == false )
  Permission.create(name: 'Transporters', description: '')
end

if (Permission.where(:name => "StockTake").present? == false )
  Permission.create(name: 'StockTake', description: '')
end
# add internal  movement Journal
if (Journal.where(:name => 'Internal Movement').present? == false)
  Journal.create(name: 'Internal Movement', description: 'used to handle stock movememt amoung hubs, warehouses and stores', code: :internal_movement)
  puts "Added Internal Movement to Journal"
end

if PaymentType.count == 0
  PaymentType.create(name: 'Commercial Bank of Ethiopia')
  PaymentType.create(name: 'Dashen Bank')
  PaymentType.create(name: 'Wegagen Bank')
  PaymentType.create(name: 'United Bank')
end



