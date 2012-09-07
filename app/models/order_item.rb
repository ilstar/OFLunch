class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :menu_item

  delegate :vendor, :name, :to => :menu_item
  before_save :set_price_according_menu_item
  after_update :update_menu_item_average_rating

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

  def update_menu_item_average_rating
    return unless self.rating_changed?

    menu_item.average_rating = (menu_item.order_items.select("SUM(rating) AS rating_sum").first.rating_sum.to_f / menu_item.order_items.count).round(1)
    menu_item.save
  end
end
