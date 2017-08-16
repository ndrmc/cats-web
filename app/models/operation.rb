# == Schema Information
#
# Table name: operations
#
#  id                  :integer          not null, primary key
#  program_id          :integer
#  hrd_id              :integer
#  fscd_annual_plan_id :integer
#  name                :string           not null
#  descripiton         :text
#  year                :string
#  round               :integer
#  month               :integer
#  expected_start      :date
#  expected_end        :date
#  actual_start        :date
#  actual_end          :date
#  status              :integer          default("draft"), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  created_by          :integer
#  modified_by         :integer
#  deleted_at          :datetime
#  ration_id           :integer
#

class Operation < ApplicationRecord
  enum status: [:draft, :ongoing, :completed, :archived]

  belongs_to :hrd
  belongs_to :ration
  belongs_to :program

  has_many :requisitions
  has_many :transport_requisitions
  has_many :transport_orders

  before_validation :reset_plan_id

  validates :program_id, presence: {message: " is required!"}
  validates :name, presence: {message: " is required!"}
  validates :year, presence: {message: " is required!"}

  validates :ration_id, presence: {message: "is required!"}

  validates :hrd_id, presence: {message: "is required!"}, if: "program_id == Program.find_by_name('Relief').id"
  validates :fscd_annual_plan_id, presence: {message: "is required!"}, if: "program_id == Program.find_by_name('PSNP').id"

  #clear previously set plan id(take only one according to the program)
  def reset_plan_id
    if (self.program_id == Program.find_by_name('IDPs').id)
      self.hrd_id = nil
      self.fscd_annual_plan_id = nil
    elsif (self.program_id == Program.find_by_name('Relief').id)
      self.fscd_annual_plan_id = nil
    elsif (self.program_id == Program.find_by_name('PSNP').id)
      self.hrd_id = nil
    end
  end
end
