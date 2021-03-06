# -*- encoding : utf-8 -*-
class MenuItem < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :vendor
  belongs_to :category
  has_many :order_items

  validates_presence_of :name, :price, :category_id

  scope :eatable, where("category_id <> ?", Category.find_by_identifier('freight').try(:id).to_i)

  def last_comment
    return unless last_order_item = order_items.order('id ASC').where("comment IS NOT NULL").last

    "#{last_order_item.order.user.name} says:<br/>#{last_order_item.comment}"
  end
end
