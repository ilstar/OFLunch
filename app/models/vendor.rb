# -*- encoding : utf-8 -*-
class Vendor < ActiveRecord::Base
  acts_as_paranoid

  has_many :menu_items

  validates_presence_of :name

  def menu_items_order_by_popular
    self.menu_items.joins("LEFT JOIN order_items ON menu_items.id = order_items.menu_item_id").group('menu_items.id').order('SUM(amount) DESC')
  end

  # return categories which belongs a certain vendor
  # format: {
  #   <Category> => [<MenuItem>, <MenuItem>]
  # }
  def categories_with_menu_items
    result = {}
    self.menu_items.each do |menu_item|
      result[menu_item.category.name] ||= {}
      result[menu_item.category.name]['category_name'] = menu_item.category.name
      result[menu_item.category.name]['menu_items'] ||= []
      result[menu_item.category.name]['menu_items'] << menu_item
    end
    result
  end
end
