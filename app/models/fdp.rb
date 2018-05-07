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
#  address     :string
#  woreda      :string
#  zone        :string
#  region      :string
#

class Fdp < ApplicationRecord
  after_initialize :init_default_vals

  belongs_to :location
  has_many :fdp_contacts

  reverse_geocoded_by :lat , :lon

  after_validation :reverse_geocode
  validates :name, presence: true

  default_scope { where(:hide_fdp => false ) }
  #attr_reader :zone, :woreda, :region

=begin
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
=end

  before_validation do

    location = Location.find(location_id)
    if location

      ancestors = location.ancestors

      self.region = ancestors.find { |a| a.location_type == 'region' } ? ancestors.find { |a| a.location_type == 'region' }.name : ''
      self.zone = ancestors.find { |a| a.location_type == 'zone' } ? ancestors.find { |a| a.location_type == 'zone' }.name : ''
      self.woreda = ancestors.find { |a| a.location_type == 'woreda' } ? ancestors.find { |a| a.location_type == 'woreda' }.name : ''

      if location.location_type == 'zone'
        self.zone = location.name
      elsif location.location_type == 'woreda'
        self.woreda = location.name
      end

    end

  end

  private
    def init_default_vals
      self.active = true if self.active.nil?
    end


end
