class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_create :update_created_by
  before_update :update_modified_by

  def update_created_by
    self.modified_by = self.created_by = Current.user.id
  end

  def update_modified_by
    self.modified_by = Current.user.id
  end
end
