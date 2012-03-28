# -*- encoding : utf-8 -*-
class MenuItem < ActiveRecord::Base
  belongs_to :vendor

  validates_presence_of :name, :price
end
