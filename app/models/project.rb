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

class Project < ApplicationRecord
  include Postable
   include Filterable

  scope :status, ->(status) { where archived:  status == 'Archived' ? true : [nil,false]}
  scope :organization_id, ->(organization_id) { where organization_id: organization_id }

  STATUSES = ["Active", "Archived"]

  validates :project_code, presence: true
  validates :commodity_id, presence: true
  validates :commodity_source_id, presence: true
  validates :organization_id, presence: true
  validates :amount, presence: true
  validates :unit_of_measure_id, presence: true
  validates :publish_date, presence: true

  belongs_to :commodity
  belongs_to :commodity_source
  belongs_to :organization
  belongs_to :unit_of_measure

  after_save :pre_post
  after_update :reverse
 

 def self.get_project(commodity_source_id)


    commodity_source_code = CommoditySource.find(commodity_source_id).code
    project_code = Project.order('id desc').where("project_code LIKE :prefix", prefix: "#{commodity_source_code}%").pluck(:project_code).first # get last record of project code
    
    if !project_code.nil? 
        sequence_number = project_code.split('/')[1] # get number
        saved_year = project_code.split('/')[2] # get year
  
        if !sequence_number.to_i.to_s
          sequence_number = '0001'
        else
          sequence_number = sequence_number.to_i + 1 # increment number by one
          zeros = ""
          i=1
          max_length = sequence_number.to_s.length
     
        for i in 1..4-max_length # append zeros
          zeros = zeros + '0'
        end

        sequence_number =  zeros + sequence_number.to_s
     end  

    else
      sequence_number = "0001"
    end
  
    if Date.today.year < saved_year.to_i   # reset year
        sequence_number ='0001'
    end

    if(commodity_source_id.to_i == CommoditySource.find_by_name('Donation').id)
       project_code = CommoditySource.find_by_name('Donation').code + '/' + sequence_number.to_s + '/' + Date.today.year.to_s
    elsif (commodity_source_id.to_i == CommoditySource.find_by_name('Local Purchase').id)
       project_code = CommoditySource.find_by_name('Local Purchase').code + '/' + sequence_number.to_s + '/' + Date.today.year.to_s
    elsif (commodity_source_id.to_i == CommoditySource.find_by_name('Loan').id)
       project_code = CommoditySource.find_by_name('Loan').code + '/' + sequence_number.to_s + '/' + Date.today.year.to_s
    elsif (commodity_source_id.to_i == CommoditySource.find_by_name('Swap').id)
       project_code = CommoditySource.find_by_name('Swap').code + '/' + sequence_number.to_s + '/' + Date.today.year.to_s
     elsif (commodity_source_id.to_i == CommoditySource.find_by_name('International Purchase').id)
       project_code = CommoditySource.find_by_name('International Purchase').code + '/' + sequence_number.to_s + '/' + Date.today.year.to_s
    else
      
    end

    return project_code

    end 
end
