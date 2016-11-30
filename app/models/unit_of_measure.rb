# == Schema Information
#
# Table name: unit_of_measures
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  description     :string
#  code            :string           not null
#  uom_type        :integer          default("ref"), not null
#  ratio           :decimal(8, 2)    not null
#  uom_category_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  created_by      :integer
#  modified_by     :integer
#  deleted_at      :datetime
#

##
# Unit of measure converation functionality. This class is used to convert quantity from one unit to another.
# Unit of measures belong to one of the available categories (weight, volume, length, time, unit)
# Each unit of measure belongs to one the types (ref, big, small). Each category MUST have a reference (standard) unit. For
# example for weight category kg is considered as reference unit, for length category meter is used as ref unit.
# Based on its type a unit will have a ratio. E.g. Quintal will have a ratio of 100 (1kg * 100 = 1qtl)
#      qtl = UnitOfMeasure.find_by(name: 'qtl')
#      qtl.to_ref(2) #will return 200kg
class UnitOfMeasure < ApplicationRecord
  belongs_to :uom_category
  enum uom_type: [:ref, :big, :small]

  ##
  # Convert passed argument 'value' to the reference unit of same category and returns an Integer. E.g.
  # 2qtl will be converted to 200kg.
  def to_ref(value)
    result = nil
    if uom_type == 'ref'
      result = value
    elsif uom_type == 'big'
      result = value * ratio
    elsif uom_type == 'small'
      result = value/ratio
    end
    result.to_i
  end

  ##
  # Converts the specified 'value' in reference unit of the same category to the provided
  # 'unit'. E.g. converts 200kg to 2 qtl
  def ref_to_unit(value)
    result = nil
    if self.uom_type == 'big'
      result = value/self.ratio
    elsif self.uom_type == 'small'
      result = value * self.ratio
    end
    result.to_i
  end

  ##
  # Converts passed 'value_in_unit' of 'unit' to the current objects unit assuming both are in the
  # same category. Unit should be the name of the unit and not the id E.g. 2mt will be converted to 200qtl
  #     qtl = UnitOfMeasure.find_by(name: 'qtl')
  #     qtl.convert_to(:mt, 20) # returns 200 by converting 20mt to qtl
  def convert_to(unit, value_in_unit)
    target_unit = UnitOfMeasure.find_by(name: unit)

    if target_unit.uom_category != self.uom_category
      raise StandardError, "Can only convert to measurment units in the same category"
    end

    incoming_ref_value = target_unit.to_ref(value_in_unit)

    result_unit_value = self.ref_to_unit(incoming_ref_value)
    result_unit_value.to_f
  end

  validates :name, presence: true
  validates :code, presence: true
  validates :uom_type, presence: true
  validates :ratio, presence: true
  validates :uom_category_id, presence: true
end
