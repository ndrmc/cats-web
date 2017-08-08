class FrameworkTender < ApplicationRecord
     enum status: [:draft, :approved, :canceled, :closed, :archived]
end
