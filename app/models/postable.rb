module Postable

  def pre_post
    return if self.draft

    if (self.is_a?(Receipt))
      logger.info "Processing posting information for Receipt"
      post_receipt
    elsif(self.is_a?(Dispatch))
      logger.info "Processing posting information for Dispatch"
      post_dispatch
    elsif(self.is_a?(Delivery))
      logger.info "Processing posting information for Delivery"
      post_delivery
    elsif(self.is_a?(Project))
      logger.info "Processing posting information for Project"
      post_project
    elsif(self.is_a?(StockTake))
      logger.info "Processing posting information for StockTake"
      post_stock_take
    end

  end


  def post_receipt
    stock_account = Account.find_by({'code': :stock})
    receivable_account = Account.find_by({'code': :receivable})
    receipt_journal = Journal.find_by({'code': :goods_received})
    posting_items = []
    self.receipt_lines.each do |receipt_line|
      amount_in_ref = UnitOfMeasure.find(receipt_line.unit_of_measure_id).to_ref(receipt_line.quantity)
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
                                quantity: -amount_in_ref

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
                                 quantity: amount_in_ref
      })
      posting_items << credit
    end

    post( Posting.document_types[:receipt], self.id, Posting.posting_types[:normal], posting_items)
  end

  def post_dispatch
    stock_account = Account.find_by({'code': :stock})
    dispatched_account = Account.find_by({'code': :dispatched})
    
    if(self.dispatch_type == "transfer")
      internal_movement_journal = Journal.find_by({'code': :internal_movement})
      posting_items = []
      self.dispatch_items.each do |dispatch_line|
        amount_in_ref = UnitOfMeasure.find(dispatch_line.unit_of_measure_id).to_ref(dispatch_line.quantity)
        debit = PostingItem.new({
                                  account_id: stock_account.id,
                                  journal_id: internal_movement_journal.id,
                                  hub_id: self.hub_id,
                                  warehouse_id: self.warehouse_id,
                                  donor_id: dispatch_line.organization_id,
                                  project_id: dispatch_line.project_id,
                                  batch_id: 1,
                                  commodity_id: dispatch_line.commodity_id,
                                  commodity_category_id: dispatch_line.commodity_category_id,
                                  quantity: -amount_in_ref
  
        })
  
        posting_items << debit
        credit = PostingItem.new({
                                   account_id: dispatched_account.id,
                                   journal_id: internal_movement_journal.id,
                                   hub_id: self.hub_id,
                                   warehouse_id: self.warehouse_id,
                                   donor_id: dispatch_line.organization_id,
                                   project_id: dispatch_line.project_id,
                                   batch_id: 1,
                                   commodity_id: dispatch_line.commodity_id,
                                   commodity_category_id: dispatch_line.commodity_category_id,
                                   quantity: amount_in_ref
        })
        posting_items << credit
      end      
    else
      good_issue_journal = Journal.find_by({'code': :goods_issue})
      posting_items = []
      self.dispatch_items.each do |dispatch_line|
        amount_in_ref = UnitOfMeasure.find(dispatch_line.unit_of_measure_id).to_ref(dispatch_line.quantity)
        debit = PostingItem.new({
                                  account_id: stock_account.id,
                                  journal_id: good_issue_journal.id,
                                  hub_id: self.hub_id,
                                  fdp_id: self.fdp_id,
                                  warehouse_id: self.warehouse_id,
                                  donor_id: dispatch_line.organization_id,
                                  project_id: dispatch_line.project_id,
                                  batch_id: 1,
                                  program_id: Operation.find(self.operation_id).program_id,
                                  operation_id: self.operation_id,
                                  commodity_id: dispatch_line.commodity_id,
                                  commodity_category_id: dispatch_line.commodity_category_id,
                                  quantity: -amount_in_ref
  
        })
  
        posting_items << debit
        credit = PostingItem.new({
                                   account_id: dispatched_account.id,
                                   journal_id: good_issue_journal.id,
                                   hub_id: self.hub_id,
                                   fdp_id: self.fdp_id,
                                   warehouse_id: self.warehouse_id,
                                   donor_id: dispatch_line.organization_id,
                                   project_id: dispatch_line.project_id,
                                   batch_id: 1,
                                   program_id: Operation.find(self.operation_id).program_id,
                                   operation_id: self.operation_id,
                                   commodity_id: dispatch_line.commodity_id,
                                   commodity_category_id: dispatch_line.commodity_category_id,
                                   quantity: amount_in_ref
        })
        posting_items << credit
      end
    end
    
    post( Posting.document_types[:dispatch], self.id, Posting.posting_types[:normal], posting_items)
  end

  def post_delivery
    delivery_account = Account.find_by({'code': :delivered})
    dispatched_account = Account.find_by({'code': :dispatched})
    lost_account = Account.find_by({'code': :lost})
    stock_account = Account.find_by({'code': :stock})


    delivery_journal = Journal.find_by({'code': :delivery})
    posting_items = []
    self.delivery_details.each do |delivery_detail|
      received_amount_in_ref = UnitOfMeasure.find(delivery_detail.uom_id).to_ref(delivery_detail.received_quantity)
      sent_amount_in_ref = UnitOfMeasure.find(delivery_detail.uom_id).to_ref(delivery_detail.sent_quantity)
      debit = PostingItem.new({
                                account_id: dispatched_account.id,
                                journal_id: delivery_journal.id,
                                fdp_id: self.fdp_id,
                                batch_id: 1,
                                program_id: Operation.find(self.operation_id).program_id,
                                operation_id: self.operation_id,
                                commodity_id: delivery_detail.commodity_id,
                                commodity_category_id: Commodity.find(delivery_detail.commodity_id).commodity_category_id,
                                quantity: -received_amount_in_ref

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
                                 quantity: received_amount_in_ref
      })
      posting_items << credit

      # do loss accounting if received quantity not equal to sent quantity (three legged posting)
      if received_amount_in_ref > sent_amount_in_ref #stock gain
        gain_credit =PostingItem.new({
                                       account_id: stock_account.id,
                                       journal_id: delivery_journal.id,
                                       fdp_id: self.fdp_id,
                                       batch_id: 1,
                                       program_id: Operation.find(self.operation_id).program_id,
                                       operation_id: self.operation_id,
                                       commodity_id: delivery_detail.commodity_id,
                                       commodity_category_id: Commodity.find(delivery_detail.commodity_id).commodity_category_id,
                                       quantity: received_amount_in_ref - sent_amount_in_ref
        })
        posting_items << gain_credit

      elsif received_amount_in_ref < sent_amount_in_ref #loss
        loss_credit =PostingItem.new({
                                       account_id: lost_account.id,
                                       journal_id: delivery_journal.id,
                                       fdp_id: self.fdp_id,
                                       batch_id: 1,
                                       program_id: Operation.find(self.operation_id).program_id,
                                       operation_id: self.operation_id,
                                       commodity_id: delivery_detail.commodity_id,
                                       commodity_category_id: Commodity.find(delivery_detail.commodity_id).commodity_category_id,
                                       quantity: sent_amount_in_ref - received_amount_in_ref
        })
        posting_items << loss_credit
      end

    end
    post( Posting.document_types[:delivery], self.id, Posting.posting_types[:normal], posting_items)
  end


  def post_project
    statistics_account = Account.find_by({'code': :statistics})
    receivable_account = Account.find_by({'code': :receivable})

    receivable_journal = nil
    if(self.commodity_source_id == CommoditySource.find_by_name('Donation').id)
      receivable_journal = Journal.find_by({'code': :donation})
    elsif (self.commodity_source_id == CommoditySource.find_by_name('Local Purchase').id)
      receivable_journal = Journal.find_by({'code': :purchase})
    elsif (self.commodity_source_id == CommoditySource.find_by_name('Loan').id)
      receivable_journal = Journal.find_by({'code': :loan})
    elsif (self.commodity_source_id == CommoditySource.find_by_name('Swap').id)
      receivable_journal = Journal.find_by({'code': :transfer})
    elsif (self.commodity_source_id == CommoditySource.find_by_name('International Purchase').id)
      receivable_journal = Journal.find_by({'code': :purchase})
    else
      raise Exception,"Commodity source unknown"
    end


    posting_items = []
    amount_in_ref = UnitOfMeasure.find(self.unit_of_measure_id).to_ref(self.amount)
    debit = PostingItem.new({
                              account_id: statistics_account.id,
                              journal_id: receivable_journal.id,
                              commodity_id: self.commodity_id,                              
                              commodity_category_id: Commodity.find(self.commodity_id).commodity_category_id,
                              quantity: -amount_in_ref,
                              donor_id: self.organization_id,
                              project_id: self.id

    })

    posting_items << debit
    credit = PostingItem.new({
                               account_id: receivable_account.id,
                               journal_id: receivable_journal.id,
                               commodity_id: self.commodity_id,
                               commodity_category_id: Commodity.find(self.commodity_id).commodity_category_id,
                               quantity: amount_in_ref,
                               donor_id: self.organization_id,
                               project_id: self.id
    })
    posting_items << credit

    post( Posting.document_types[:project], self.id, Posting.posting_types[:normal], posting_items)
  end

  def post_stock_take
    statistics_account = Account.find_by({'code': :statistics})
    stock_account = Account.find_by({'code': :stock})
    lost_account = Account.find_by({'code': :lost})

    stock_take_journal =  Journal.find_by({'code': :annual_inventory})
    posting_items = []
    self.adjustments.each do |adjustment|
      Rails.logger.info "posting -----#{adjustment.adjustment_type}   #{Adjustment.adjustment_types[:loss]}"
      if adjustment.loss?

        debit = PostingItem.new({
                                  account_id: stock_account.id,
                                  journal_id: stock_take_journal.id,
                                  commodity_id: adjustment.commodity_id,
                                  commodity_category_id: adjustment.commodity_category_id,
                                  quantity: -adjustment.amount,
                                  hub_id: adjustment.stock_take.hub_id,
                                  warehouse_id: adjustment.stock_take.warehouse_id,
                                  store_id: adjustment.stock_take.store_no,
                            donor_id: adjustment.stock_take_item.donor_id,
                            project_id: adjustment.stock_take_item.project_id                                        

        })

        posting_items << debit
        credit = PostingItem.new({
                            account_id: lost_account.id,
                                   journal_id: stock_take_journal.id,
                                   commodity_id: adjustment.commodity_id,
                                   commodity_category_id: adjustment.commodity_category_id,
                                   quantity: adjustment.amount,
                                   hub_id: adjustment.stock_take.hub_id,
                                   warehouse_id: adjustment.stock_take.warehouse_id,
                                   store_id: adjustment.stock_take.store_no,
                            donor_id: adjustment.stock_take_item.donor_id,
                            project_id: adjustment.stock_take_item.project_id  
        })
        posting_items << credit
      elsif adjustment.gain?
        debit = PostingItem.new({
                                  account_id: statistics_account.id,
                                  journal_id: stock_take_journal.id,
                                  commodity_id: adjustment.commodity_id,
                                  commodity_category_id: adjustment.commodity_category_id,
                                  quantity: -adjustment.amount,
                                  hub_id: adjustment.stock_take.hub_id,
                                  warehouse_id: adjustment.stock_take.warehouse_id,
                                  store_id: adjustment.stock_take.store_no,
                            donor_id: adjustment.stock_take_item.donor_id,
                            project_id: adjustment.stock_take_item.project_id                                                

        })

        posting_items << debit
        credit = PostingItem.new({
                                   account_id: stock_account.id,
                                   journal_id: stock_take_journal.id,
                                   commodity_id: adjustment.commodity_id,
                                   commodity_category_id: adjustment.commodity_category_id,
                                   quantity: adjustment.amount,
                                   hub_id: adjustment.stock_take.hub_id,
                                   warehouse_id: adjustment.stock_take.warehouse_id,
                                   store_id: adjustment.stock_take.store_no,
                            donor_id: adjustment.stock_take_item.donor_id,
                            project_id: adjustment.stock_take_item.project_id  

        })
        posting_items << credit
      end
    end
    post( Posting.document_types[:stock_take], self.id, Posting.posting_types[:normal], posting_items)

  end


  def post(document_type, document_id, posting_type, posting_items)

    if(!validate(posting_items))
      raise Exception, "Posting items did not pass validation."
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
      original_posting = Posting.where('document_id': self.id, "posting_type": :normal).first
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