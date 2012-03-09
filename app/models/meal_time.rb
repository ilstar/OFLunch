# -*- encoding : utf-8 -*-
class MealTime < ActiveRecord::Base
  has_many :menu_of_meals, :dependent => :destroy
  has_many :vendors, :through => :menu_of_meals
  has_many :orders
  has_many :order_items, :through => :orders

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

  def lock
    self.update_attribute(:status, "locked")
  end

  def locked?
    self.status == "locked"
  end

  def unlock?
    self.status.nil?
  end

  def close
    begin
      self.transaction do
        self.status = "closed"
        self.orders.map(&:pay) 
        self.save!
      end
    rescue ActiveRecord::RecordInvalid
     return false
    end
    true
  end

  def closed?
    self.status == "closed"
  end

  def can_not_order_now?
    self.closed? || self.locked?
  end

  protected

  def less_than_two_vendors_choosed
    self.errors.add :vendor_ids, I18n.t('meal_time.no_more_than_2_vendors') if self.vendors.size > 2
    self.errors.add :vendor_ids, I18n.t('meal_time.no_vendor_selected') if self.vendors.size == 0
  end

  def no_more_than_one_meal_per_day
    self.errors.add :base, I18n.t('meal_time.exists_today') if self.new_record? && self.class.today
  end
end
