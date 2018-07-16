namespace :cats do
    namespace :ration do
        desc "update commodity id in ration items with commodity category id"
        @ration_items= []
       
            task update_commodity_on_ration: :environment do
                puts "Started updating commodity id ...."
                @total = RationItem.all.count
                @i = 0
                RationItem.find_each do |ration_item|
                
                @commodity_category_id = Commodity.find_by(id: ration_item.commodity_id)&.commodity_category_id

                printf("\rUpdating...: %d%", (@i/@total))
                sleep(0.1)
                @i = @i + 100
                if  @commodity_category_id.present?
                        @ration_item = RationItem.find(ration_item.id)
                        @ration_item.commodity_id = @commodity_category_id 
                        @ration_item.save(validate: false)
                
                else
                
                end

            end
            printf("\rUpdating...: %d%", (@i/@total))
            puts
            
                     
            
            
        end
        
    end
    
end

