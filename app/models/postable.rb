module Postable
  
    def pre_post  
        return if self.draft
        if(self.is_a?(Receipt))
             
                stock_account = Account.find_by({'code': :stock})
                receivable_account = nil 
                    if(self.commodity_source_id == 1)
                        receivable_account = Account.find_by({'code': :pledged})
                    elsif (self.commodity_source_id == 3)
                        receivable_account = Account.find_by({'code': :purchased})
                    elsif (self.commodity_source_id == 2)
                        receivable_account = Account.find_by({'code': :borrowed})
                    else
                        raise Exception('Commodity source unknown')
                    end

            receipt_journal = Journal.find_by({'code': :goods_received})
            posting_items = []
            self.receipt_lines.each do |receipt_line|
                debit = PostingItem.new({
                    account_id: receivable_account.id,
                    journal_id: receipt_journal.id,
                    donor_id: self.supplier_id,
                    hub_id: self.hub_id,
                    warehouse_id: self.warehouse_id,
                    project_id: receipt_line.project_id,
                    batch_id: 1,
                    program_id: self.program_id,
                    commodity_id: receipt_line.commodity_id,
                    commodity_category_id: receipt_line.commodity_category_id,
                    quantity: -receipt_line.quantity

                })

                posting_items << debit
                credit = PostingItem.new({
                        account_id: stock_account.id,
                        journal_id: receipt_journal.id,
                        donor_id: self.supplier_id,
                        hub_id: self.hub_id,
                        warehouse_id: self.warehouse_id,
                        project_id: receipt_line.project_id,
                        batch_id: 1,
                        program_id: self.program_id,
                        commodity_id: receipt_line.commodity_id,
                        commodity_category_id: receipt_line.commodity_category_id,
                        quantity: receipt_line.quantity
                })
                posting_items << credit
            end 



            post( Posting.document_types[:receipt], self.id, Posting.posting_types[:normal], posting_items)
        
        elsif(self.is_a?(Dispatch))
              stock_account = Account.find_by({'code': :stock})
              dispatched_account = Account.find_by({'code': :dispatched})
                    

            good_issue_journal = Journal.find_by({'code': :goods_issue})
            posting_items = []
            self.dispatch_items.each do |dispatch_line|
                debit = PostingItem.new({
                    account_id: stock_account.id,
                    journal_id: good_issue_journal.id,
                    hub_id: 1,
                    fdp_id: self.fdp_id,                    
                    warehouse_id: 1,
                    donor_id: dispatch_line.organization_id,
                    project_id: dispatch_line.project_id,
                    batch_id: 1,
                    program_id: Operation.find(self.operation_id).program_id,
                    operation_id: self.operation_id,
                    commodity_id: dispatch_line.commodity_id,
                    commodity_category_id: dispatch_line.commodity_category_id,
                    quantity: -dispatch_line.quantity

                })

                posting_items << debit
                credit = PostingItem.new({
                        account_id: dispatched_account.id,
                        journal_id: good_issue_journal.id,
                        hub_id: 1,
                        fdp_id: self.fdp_id,                    
                        warehouse_id: 1,
                        donor_id: dispatch_line.organization_id,
                        project_id: dispatch_line.project_id,
                        batch_id: 1,
                        program_id: Operation.find(self.operation_id).program_id,
                        operation_id: self.operation_id,
                        commodity_id: dispatch_line.commodity_id,
                        commodity_category_id: dispatch_line.commodity_category_id,
                        quantity: dispatch_line.quantity
                })
                posting_items << credit
            end 



            post( Posting.document_types[:dispatch], self.id, Posting.posting_types[:normal], posting_items)
        
        
        
        elsif(self.is_a?(Delivery))
                delivery_account = Account.find_by({'code': :delivered})
                dispatched_account = Account.find_by({'code': :dispatched})
                        

                delivery_journal = Journal.find_by({'code': :delivery})
                posting_items = []
                self.delivery_details.each do |delivery_detail|
                    debit = PostingItem.new({
                        account_id: dispatched_account.id,
                        journal_id: delivery_journal.id,
                        fdp_id: self.fdp_id, 
                        batch_id: 1,
                        program_id: Operation.find(self.operation_id).program_id,
                        operation_id: self.operation_id,
                        commodity_id: delivery_detail.commodity_id,
                        commodity_category_id: Commodity.find(delivery_detail.commodity_id).commodity_category_id,
                        quantity: -delivery_detail.received_quantity

                    })

                    posting_items << debit
                    credit = PostingItem.new({
                        account_id: delivery_account.id,
                        journal_id: delivery_journal.id,
                        fdp_id: self.fdp_id, 
                        batch_id: 1,
                        program_id: Operation.find(self.operation_id).program_id,
                        operation_id: self.operation_id,
                        commodity_id: delivery_detail.commodity_id,
                        commodity_category_id: Commodity.find(delivery_detail.commodity_id).commodity_category_id,
                        quantity: delivery_detail.received_quantity
                    })
                    posting_items << credit
                end 



                post( Posting.document_types[:delivery], self.id, Posting.posting_types[:normal], posting_items)
            
            
            end
    
    end

    def post(document_type, document_id, posting_type, posting_items) 

        if(!validate(posting_items))
            raise Exception("Posting items did not pass validation.");
        end

        posting = Posting.new({
            document_id: document_id,
            document_type: document_type,
            posting_type: posting_type,
            posting_items: posting_items
        })
        
       posting.save!
        
    end

    def reverse

        return if self.draft
        original_posting = Posting.find_by({'document_id': self.id})
        original_posting.posting_type = Posting.posting_types[:reversed]
       
        original_posting.save!

        reversal_items = []
        original_posting.posting_items.each do |posting_item|
            reversal_item = posting_item.dup
            reversal_item.quantity = -reversal_item.quantity
            reversal_items << reversal_item
         end

        reversal_posting = Posting.new({
            posting_type: Posting.posting_types[:reversal],
            reversed_posting_id: original_posting.id,
            document_type: original_posting.document_type,
            document_id: original_posting.document_id,
            posting_items: reversal_items
        })
       
       
       reversal_posting.save!
       

    end

    def validate(posting_items)
        posting_items.map { |h| h[:quantity] }.sum == 0
     
    end
end