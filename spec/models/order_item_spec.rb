require 'spec_helper'

describe OrderItem do
  describe "before save" do
    it "set price according to menu item price" do
      menu_item = FactoryGirl.create :menu_item

      order_item = FactoryGirl.create :order_item, menu_item: menu_item, amount: 2, price: nil

      order_item.price.should == menu_item.price
    end
  end
end
