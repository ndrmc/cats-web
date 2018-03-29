class ApplicationRecord < ActiveRecord::Base
  acts_as_paranoid
  self.abstract_class = true
  before_update :update_change_tracking

  # before_create :update_created_by
  # before_update :update_modified_by

  # def update_created_by
  #   self.modified_by = self.created_by = Current.user ? Current.user.id : nil
  # end

  # def update_modified_by
  #   self.modified_by = Current.user ? Current.user.id : nil
  # end

  def update_change_tracking
    self.is_dirty = true
  end
end
