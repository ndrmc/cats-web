UserType = GraphQL::ObjectType.define do
  name 'User'
  description '...'

  field :id, !types.String
  field :email, !types.String
  field :name, !types.String
  field :region, types.String
  field :hub, types.String
end

CommodityType = GraphQL::ObjectType.define do
  name 'Commodity'
  description '...'

  field :id, !types.ID
  field :name, !types.String
  field :longName, types.String, property: :long_name
end

LocationType = GraphQL::ObjectType.define do
  name 'Location'
  description '...'

  field :id, !types.ID
  field :name, !types.String
  field :code, types.String
  field :locationType, types.String, property: :location_type
  field :children do
    type types[LocationType]
    description 'Children locations'
    resolve -> (obj, args, ctx) {obj.descendants}
  end
end

RationItemType = GraphQL::ObjectType.define do
  name 'RationItemType'
  description '...'

  field :id, !types.ID
  field :amount, types.String
  field :commodity do
    type CommodityType
    description '...'
    resolve -> (obj, args, ctx) {obj.commodity}
  end
end

RationType = GraphQL::ObjectType.define do
  name 'RationType'
  description '...'

  field :id, !types.ID
  field :referenceNo, !types.String, property: :reference_no
  field :description, types.String
  field :items do
    type types[RationItemType]
    description '...'
    resolve -> (obj, args, ctx) {obj.ration_items}
  end

end

HrdItemType = GraphQL::ObjectType.define do
  name 'HrdItemType'
  description '...'

  field :id, !types.ID
  field :duration, types.String
  field :startingMonth, types.String, property: :starting_month
  field :beneficiary, types.String
  field :woreda do
    type LocationType
    description 'Woreda for which beneficiaries are identified'
    resolve -> (obj, args, ctx) {obj.woreda}
  end
end

HrdType = GraphQL::ObjectType.define do
  name 'Hrd'
  description '...'

  field :id, !types.ID
  field :year, types.String, property: :year_gc
  field :startingMonth, types.String, property: :month_from
  field :ration do
    type RationType
    description 'Ration for HRD'
    resolve -> (obj, args,ctx){obj.ration}
  end  
  field :items do
    type types[HrdItemType]
    description '...'
    resolve -> (obj, args, ctx) {obj.hrd_items}
  end
end

ReceiptType = GraphQL::ObjectType.define do
  name 'Receipt'
  description ''

  field :id, !types.ID
  field :grnNo, !types.String, property: :grn_no
  field :plateNo, types.String, property: :plate_no
  field :storekeeperName, types.String, property: :storekeeper_name
  field :items do
    type types[ReceiptItemType]
    description 'Receipt items'
    resolve -> (obj, args,ctx) {obj.receipt_lines}
  end
end

ReceiptItemType = GraphQL::ObjectType.define do
  name 'ReceiptItem'
  description ''

  field :id, !types.ID
  field :quantity, types.String
  field :commodity do
    type CommodityType
    description 'Receipt item commodity'
    resolve -> (obj, args, ctx) {obj.commodity}
  end
end

QueryRoot = GraphQL::ObjectType.define do
  name 'Query'
  description '...'

  field :user do
    type UserType
    argument :id, !types.String
    resolve -> (root, args, ctx) {
      User.find(args[:id])
    }
  end


  field :grn do
    type ReceiptType
    argument :id, !types.ID
    resolve  RescueFrom.new(ActiveRecord::RecordNotFound, ->(root, args, ctx){
      Receipt.find(args[:id])
    })
  end

  field :location do
    type LocationType
    argument :id, !types.ID
    resolve RescueFrom.new(ActiveRecord::RecordNotFound, -> (root, args, ctx){
      Location.find(args[:id])
      })
  end

  field :hrd do
    type HrdType
    argument :id, !types.ID
    resolve -> (root,args,ctx){Hrd.find(args[:id])}
  end

end

Schema = GraphQL::Schema.define do
  query QueryRoot
end
