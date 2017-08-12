class WarehouseSelection < ApplicationRecord
     
      belongs_to :framework_tender, foreign_key: 'framework_tender_id'

      def woreda 
        Location.find location_id
      end

      def hub
          Warehouse.find warehouse_id
      end

      def framework_tender
        FrameworkTender.find framework_tender_id
      end
      
end
