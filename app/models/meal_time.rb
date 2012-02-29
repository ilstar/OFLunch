class MealTime < ActiveRecord::Base
  has_many :menu_of_meals, :dependent => :destroy
  has_many :vendors, :through => :menu_of_meals


  attr_accessor :vendor_ids


  def self.today
    where(["created_at > ? AND created_at < ?", Time.current.beginning_of_day, Time.current.end_of_day]).first
  end

  def vendor_ids=(ids)
    puts ids
  end
end
