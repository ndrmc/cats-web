class WarehouseAllocation < ApplicationRecord
    enum status: [:pending, :ready, :allocated, :closed]
    has_many :warehouse_allocation_items
    belongs_to :operation
    belongs_to :region, :class_name => 'Location', :foreign_key => 'region_id'

    def self.get_regions(operation_id)
        @warehouse_allocations = []
        @zones = Requisition.where(:operation_id => operation_id).select(:zone_id).uniq { |s| s.zone.parent.id }
        @regions = []
        @zones.each do |zone|
          region = Location.find(zone.zone_id).parent
          if (!@regions.include?(region))
            @regions << region
          end
        end
        
        @regions.each do |region|
          @unready_allocation_count = Requisition.where(:operation_id => operation_id, :status => :draft).where('zone_id IN (?)', Location.find(region.id).descendants.where(:location_type => :zone).select(:id)).count
        
          @total_allocation_count = Requisition.where(:operation_id => operation_id).where('zone_id IN (?)', Location.find(region.id).descendants.where(:location_type => :zone).select(:id)).count
        
          @warehouse_allocation = WarehouseAllocation.where(:region_id => region.id, :operation_id => operation_id).first
        
          @ready_allocation_count = @total_allocation_count - @unready_allocation_count
        
          @progress = ( @ready_allocation_count.to_f / @total_allocation_count.to_f) * 100
        
          if (@warehouse_allocation.present? && @warehouse_allocation.status == "closed")
            @warehouse_allocations << { :region_id =>  region.id, :region_name => region.name, :status => :closed, :progress => @progress}
          elsif (@warehouse_allocation.present? && @warehouse_allocation.status == "allocated")
            @edited_wa_count = @warehouse_allocation.warehouse_allocation_items.where(:status => :edited).count
            if(@edited_wa_count > 0)
              @warehouse_allocations << { :region_id =>  region.id, :region_name => region.name, :status => :allocated, :progress => @progress, :edited => true, :warehouse_allocation_id => @warehouse_allocation.id }
            else
              @warehouse_allocations << { :region_id =>  region.id, :region_name => region.name, :status => :allocated, :progress => @progress, :edited => false, :warehouse_allocation_id => @warehouse_allocation.id }
            end            
          elsif (@unready_allocation_count == 0)
            @warehouse_allocations << { :region_id =>  region.id, :region_name => region.name, :status => :ready, :progress => @progress}
          else
            @warehouse_allocations << { :region_id =>  region.id, :region_name => region.name, :status => :pending, :progress => @progress}
          end
        end 
        return @warehouse_allocations 
    end

    def self.generate(operation_id, region_id)
      @warehouse_allocation = WarehouseAllocation.new
      @warehouse_allocation.operation_id = operation_id
      @warehouse_allocation.region_id = region_id
      @warehouse_allocation.status = :allocated
      # @warehouse_allocation.created_by = current_user_id
      @warehouse_allocation.save

      @requisitions = Requisition.includes(:requisition_items).where(:operation_id => operation_id).where('zone_id IN (?)', Location.find(region_id).descendants.where(:location_type => :zone).select(:id))

      @requisitions.each do |requisition|
        requisition.requisition_items.each do |requisition_item|
          @fdp = Fdp.includes(location: [warehouse: :hub]).find(requisition_item.fdp_id)
          @warehouse_allocation_item = WarehouseAllocationItem.new
          @warehouse_allocation_item.warehouse_allocation_id = @warehouse_allocation.id
          @warehouse_allocation_item.zone_id = @fdp&.location&.parent&.id
          @warehouse_allocation_item.woreda_id = @fdp&.location&.id
          @warehouse_allocation_item.fdp_id = @fdp.id
          @warehouse_allocation_item.hub_id = @fdp&.location&.warehouse&.hub&.id
          @warehouse_allocation_item.warehouse_id = @fdp&.location&.warehouse&.id
          @warehouse_allocation_item.requisition_id = requisition.id
          @warehouse_allocation_item.status = :draft
          # @warehouse_allocation_item.created_by = current_user_id
          @warehouse_allocation_item.save
        end
      end
      return true
    end

    def self.reset_allocation(warehouse_allocation_id)
      if(warehouse_allocation_id.present?)
        @old_warehouse_allocation = WarehouseAllocation.includes(:warehouse_allocation_items).find(warehouse_allocation_id)

        WarehouseAllocation.includes(:warehouse_allocation_items).find(warehouse_allocation_id).warehouse_allocation_items.delete_all
        WarehouseAllocation.find(warehouse_allocation_id).delete

        @warehouse_allocation = WarehouseAllocation.new
        @warehouse_allocation.operation_id = @old_warehouse_allocation.operation_id
        @warehouse_allocation.region_id = @old_warehouse_allocation.region_id
        @warehouse_allocation.status = :allocated
        @warehouse_allocation.save

        @old_warehouse_allocation.warehouse_allocation_items.each do |wai|
          @fdp = Fdp.includes(location: [warehouse: :hub]).find(wai.fdp_id)
          @warehouse_allocation_item = WarehouseAllocationItem.new
          @warehouse_allocation_item.warehouse_allocation_id = @warehouse_allocation.id
          @warehouse_allocation_item.zone_id = @fdp&.location&.parent&.id
          @warehouse_allocation_item.woreda_id = @fdp&.location&.id
          @warehouse_allocation_item.fdp_id = @fdp.id
          @warehouse_allocation_item.hub_id = @fdp&.location&.warehouse&.hub&.id
          @warehouse_allocation_item.warehouse_id = @fdp&.location&.warehouse&.id
          @warehouse_allocation_item.requisition_id = wai.requisition_id
          @warehouse_allocation_item.status = :draft
          # @warehouse_allocation_item.created_by = current_user_id
          @warehouse_allocation_item.save
        end
        return true
      else
        return false
      end
    end

    def self.reverse_allocation(warehouse_allocation_id)
         if(warehouse_allocation_id.present?)
              @old_warehouse_allocation = WarehouseAllocation.includes(:warehouse_allocation_items).find(warehouse_allocation_id)

              WarehouseAllocation.includes(:warehouse_allocation_items).find(warehouse_allocation_id).warehouse_allocation_items.delete_all
              WarehouseAllocation.find(warehouse_allocation_id).delete
              return true
        end
        return false
    end
    
    def self.check_warehouse_allocation_in_TR(operation_id, region_id)
      @waerhouse_allocations_requisition_ids = WarehouseAllocation.includes(:warehouse_allocation_items).where(:operation_id => operation_id, :region_id => region_id).pluck('warehouse_allocation_items.requisition_id').uniq

      @tr_requisition_ids =  TransportRequisition.includes(:transport_requisition_items) .where(location_id: region_id, operation_id: operation_id ).pluck('transport_requisition_items.requisition_id').uniq

      puts "================================"
      puts "Region id: " + region_id.to_s + "  " + ((@waerhouse_allocations_requisition_ids.to_a & @tr_requisition_ids.to_a).empty?).to_s
      puts "================================"
      #if they have at least one element in common,it returns false emplying TR is created
      return (@waerhouse_allocations_requisition_ids.to_a & @tr_requisition_ids.to_a).empty?

    end
end


