# == Schema Information
#
# Table name: suppliers
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  created_by  :integer
#  modified_by :integer
#  deleted     :boolean          default(FALSE)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Supplier < ApplicationRecord
end
