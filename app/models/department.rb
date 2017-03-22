class Department < ApplicationRecord
    validates_uniqueness_of :name
end
