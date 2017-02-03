class Receipt < ApplicationRecord
    acts_as_paranoid

    has_many :receipt_lines 

end
