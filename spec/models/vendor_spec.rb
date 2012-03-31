# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Vendor do
  it { should have_many(:menu_items) }

  before do
    @vendor = Factory(:vendor)
  end

  describe "#menu_items_order_by_popular" do
    before do
      @meal_time = Factory(:meal_time)
      @order = Factory(:order, meal_time: @meal_time)
    end

    it "has corret order" do
      menu_has_0_order = Factory(:menu_item, vendor: @vendor)

      menu_has_1_order = Factory(:menu_item, vendor: @vendor)
      Factory(:order_item, menu_item: menu_has_1_order, order: @order)

      menu_has_2_order = Factory(:menu_item, vendor: @vendor)
      Factory(:order_item, menu_item: menu_has_2_order, order: @order)
      Factory(:order_item, menu_item: menu_has_2_order, order: @order)

      menu_has_3_order = Factory(:menu_item, vendor: @vendor)
      Factory(:order_item, menu_item: menu_has_3_order, order: @order)
      Factory(:order_item, menu_item: menu_has_3_order, order: @order)
      Factory(:order_item, menu_item: menu_has_3_order, order: @order)


      @vendor.menu_items_order_by_popular.should == [
        menu_has_3_order,
        menu_has_2_order,
        menu_has_1_order,
        menu_has_0_order,
      ]
    end
  end
end
