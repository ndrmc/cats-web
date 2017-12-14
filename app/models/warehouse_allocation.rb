class WarehouseAllocation < ApplicationRecord
    enum status: [:pending, :ready, :generated]
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
        
          @warehouse_allocation = WarehouseAllocation.where(:region_id => region.id, :operation_id => operation_id)
        
          @ready_allocation_count = @total_allocation_count - @unready_allocation_count
        
          @progress = ( @ready_allocation_count.to_f / @total_allocation_count.to_f) * 100
        
          if (@warehouse_allocation.present? && @unready_allocation_count == 0)
            @warehouse_allocations << { :region_id =>  region.id, :region_name => region.name, :status => :generated, :progress => @progress}
          elsif (@unready_allocation_count == 0)
            @warehouse_allocations << { :region_id =>  region.id, :region_name => region.name, :status => :ready, :progress => @progress}
          else
            @warehouse_allocations << { :region_id =>  region.id, :region_name => region.name, :status => :pending, :progress => @progress}
          end
        end 
        return @warehouse_allocations 
    end
end


