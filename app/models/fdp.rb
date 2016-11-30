# == Schema Information
#
# Table name: fdps
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string
#  lat         :decimal(15, 13)
#  lon         :decimal(15, 13)
#  active      :boolean
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#

class Fdp < ApplicationRecord
  after_initialize :init_default_vals

  belongs_to :location
  has_many :fdp_contacts


  attr_reader :zone, :woreda, :region

  after_find do |fdp|
    location = location_id ? Location.find(location_id) : nil

    if location
      if location.location_type == 'zone'
        @zone = location
      elsif location.location_type == 'woreda'
        @woreda = location
      end

      ancestors = location.ancestors


      @region = @region ? @region : ancestors.find { |a| a.location_type == 'region' }
      @zone = @zone ? @zone : ancestors.find { |a| a.location_type == 'zone' }
      @woreda = @woreda ? @woreda : ancestors.find { |a| a.location_type == 'woreda' }
    end

  end

  private
    def init_default_vals
      self.active = true if self.active.nil?
    end
end
