class MealTime < ActiveRecord::Base
  has_many :menu_of_meals, :dependent => :destroy
  has_many :vendors, :through => :menu_of_meals


  attr_accessor :vendor_ids


  def self.today
    where(["created_at > ? AND created_at < ?", Time.current.beginning_of_day, Time.current.end_of_day]).first
  end

  def vendor_ids
    self.vendors.map &:id
  end
  def vendor_ids=(ids)
    self.vendors = Vendor.find ids.reject(&:blank?)
  end

  validate :less_than_two_vendors_choosed 
  validate :no_more_than_one_meal_per_day

  protected

  def less_than_two_vendors_choosed
    self.errors.add :vendor_ids, "no more than 2 vendors." if self.vendors.size > 2
    self.errors.add :vendor_ids, "no vendor selected" if self.vendors.size == 0
  end

  def no_more_than_one_meal_per_day
    self.errors.add :base, "no more than one meal per day" if self.class.today 
  end
end
