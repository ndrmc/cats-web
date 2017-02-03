class ReceiptsController < ApplicationController


    def new 
        @receipt = Receipt.new
    end
end
