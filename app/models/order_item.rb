class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :menu_item

  delegate :vendor, :name, :to => :menu_item
  before_save :set_price_according_menu_item

  def total_price
    self.price * self.amount
  end

  def menu_item_with_deleted
    MenuItem.with_deleted.find_by_id self.menu_item_id
  end

  protected

  def set_price_according_menu_item
    self.price = self.menu_item.price
  end
end
