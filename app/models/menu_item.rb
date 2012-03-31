# -*- encoding : utf-8 -*-
class MenuItem < ActiveRecord::Base
  belongs_to :vendor
  has_many :order_items

  validates_presence_of :name, :price
end
