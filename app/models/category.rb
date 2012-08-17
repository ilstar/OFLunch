class Category < ActiveRecord::Base
  attr_accessible :deleted_at, :identifier, :name
  has_many :menu_items
end
