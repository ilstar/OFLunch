class MealTime < ActiveRecord::Base
  has_many :menu_of_meals, :dependent => :destroy
  has_many :vendors, :through => :menu_of_meals

  validate :less_than_two_vendors_choosed

  attr_accessor :vendor_ids

  def less_than_two_vendors_choosed
  end

  def vendor_ids=(ids)
    puts ids
  end
end
