class StockTakePolicy < ApplicationPolicy

    def index?
    return true
    end

    def new?
        return true
    end

    def create?
        return true
    end

    def update?
    return true
    end

end
