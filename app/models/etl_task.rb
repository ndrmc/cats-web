# == Schema Information
#
# Table name: etl_tasks
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  executed    :boolean
#  executed_at :datetime
#  description :text
#  created_by  :integer
#  modified_by :integer
#  deleted     :boolean          default(FALSE)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class EtlTask < ApplicationRecord
end
