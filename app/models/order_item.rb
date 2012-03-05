class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :menu_item

  delegate :serial_num, :vendor, :name, :to => :menu_item

  def total_price
    self.price * self.amount
  end
end
