# -*- encoding : utf-8 -*-
class MenuItem < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :vendor
  belongs_to :category
  has_many :order_items

  validates_presence_of :name, :price, :category_id
end
