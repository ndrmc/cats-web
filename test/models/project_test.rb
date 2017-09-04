# == Schema Information
#
# Table name: projects
#
#  id                      :integer          not null, primary key
#  project_code            :string
#  commodity_id            :integer
#  commodity_source_id     :integer
#  organization_id         :integer
#  amount                  :decimal(, )
#  unit_of_measure_id      :integer
#  publish_date            :date
#  created_by              :integer
#  modified_by             :integer
#  deleted_at              :datetime
#  created_at              :datetime
#  updated_at              :datetime
#  old_id                  :integer
#  reference_no            :string
#  si_id                   :integer
#  si_value                :text
#  draft                   :boolean          default(FALSE)
#  archived                :boolean
#  commodity_categories_id :integer
#  program_id              :integer
#

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
