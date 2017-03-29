UserType = GraphQL::ObjectType.define do
  name 'User'
  description '...'

  field :id, !types.String
  field :email, !types.String
  field :name, !types.String
  field :region, types.String
  field :hub, types.String
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

CommodityType = GraphQL::ObjectType.define do
  name 'Commodity'
  description '...'

  field :id, !types.ID
  field :name, !types.String
  field :longName, types.String, property: :long_name
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

end

Schema = GraphQL::Schema.define do
  query QueryRoot
end
