class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :menu_item

  delegate :serial_num, :vendor, :name, :to => :menu_item

  def total_price
    self.price * self.amount
  end

  def menu_item_with_deleted
    MenuItem.with_deleted.find_by_id self.menu_item_id
  end
end
