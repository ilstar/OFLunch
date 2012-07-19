# -*- encoding : utf-8 -*-
class Order < ActiveRecord::Base
  has_many :order_items, :dependent => :destroy
  belongs_to :meal_time
  belongs_to :user
  scope :for_user_id, lambda { |user_id| where(:user_id => user_id) }

  validate :user_could_order_once, on: :create


  accepts_nested_attributes_for :order_items

  def total_price
    self.order_items.inject(0) { |sum, oi| sum += oi.price * oi.amount }
  end

  def user_could_order_once
    self.errors.add(:base, "只能定一次") if self.meal_time.orders.for_user_id(self.user_id).count >= 1
  end

  def pay
    self.user.balance.deduct(self.total_price)
  end
end
