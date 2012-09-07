require 'spec_helper'

describe OrderItem do
  describe "before save" do
    it "set price according to menu item price" do
      menu_item = FactoryGirl.create :menu_item

      order_item = FactoryGirl.create :order_item, menu_item: menu_item, amount: 2, price: nil

      order_item.price.should == menu_item.price
    end
  end

  describe "#update_menu_item_average_rating" do
    it "updates menu_item average_rating" do
      meal_time = FactoryGirl.create :meal_time
      order = FactoryGirl.create :order, meal_time: meal_time
      menu_item = FactoryGirl.create :menu_item

      # don't involve it when calculating average_rating because it's rating is nil
      FactoryGirl.create :order_item, menu_item: menu_item, order: order

      order_item = FactoryGirl.create :order_item, menu_item: menu_item, order: order
      order_item.rating = 4
      order_item.save

      menu_item.average_rating.should == 4

      order_item = FactoryGirl.create :order_item, menu_item: menu_item, order: order
      order_item.rating = 1
      order_item.save

      menu_item.average_rating.should == 2.5 # (4 + 1) / 2
    end
  end
end
