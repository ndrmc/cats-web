#!/usr/bin/env ruby
# encoding: utf-8
gem 'bunny'



module Send

    def pre_send
        
        if (self.is_a?(Operation))
            logger.info "Sending Operation denormalized json to CATS analytics through rabbitmq"
            publish_operation
        elsif (self.is_a?(Receipt))
            logger.info "Sending Receipt denormalized json to CATS analytics through rabbitmq"
          post_receipt
        elsif(self.is_a?(Dispatch))
            logger.info "Sending Dispatch denormalized json to CATS analytics through rabbitmq"
          post_dispatch
        elsif(self.is_a?(Delivery))
            logger.info "Sending Delivery denormalized json to CATS analytics through rabbitmq"
          post_delivery
        elsif(self.is_a?(Project))
            logger.info "Sending Project denormalized json to CATS analytics through rabbitmq"
          post_project
        elsif(self.is_a?(StockTake))
            logger.info "Sending StockTake denormalized json to CATS analytics through rabbitmq"
          post_stock_take
        end
    
    end

    def publish_operation        
        conn = Bunny.new(:automatically_recover => false)
        conn = Bunny.new(:host => "192.168.69.123", :user => "cats", :password => "cats")
        # conn = Bunny.new("amqp://cats:cats@192.168.69.123:5672")
        conn.start
        ch   = conn.create_channel 
        q = ch.queue("operation")

        # operations = { :id => "123456", :name => "2008-Relief-Round-1" }

        # q.publish("Hi, This cats-web!")

        # operation_json = '{
        #     "operationId": "#{self.id}",
        #     "name": "#{self.name}",
        #     "description": "#{self.description}",
        #     "hrdId": #{self.hrd_id},
        #     "hrdName": "#{self.hrd.name}",
        #     "programId": #{self.program_id},
        #     "programName": "#{self.id}",
        #     "fscdAnnualPlanId": 0,
        #     "fscdAnnualPlanName": "string",
        #     "year": 0,
        #     "round": 0,
        #     "month": "string",
        #     "expectedStart": 1508326903286,
        #     "expectedEnd": 1508326903286,
        #     "actualStart": 1508326903286,
        #     "actualEnd": 1508326903286,
        #     "status": "string",
        #     "createdAt": 1508326903286,
        #     "updatedAt": 1508326903286,
        #     "createdById": 0,
        #     "createdByName": "string",
        #     "modifiedById": 4,
        #     "modifiedByName": "string",
        #     "deletedAt": 1508326903286,
        #     "rationItems": [
        #       {
        #         "id": "string",
        #         "rationItemId": 0,
        #         "rationId": 0,
        #         "rationName": "string",
        #         "commodityId": 0,
        #         "commodityName": "string",
        #         "amount": 0,
        #         "unitOfMeasureId": 0,
        #         "unitOfMeasureName": "string"
        #       }
        #     ],
        #     "regionalRequests": null,
        #     "requisitions": null,
        #     "dispatches": null,
        #     "deliveries": null
        # }'

        ch.default_exchange.publish(self.to_json, :routing_key => q.name)
        puts " [x] Sent 'Hi, This cats-web!'"

        conn.close
    end
end