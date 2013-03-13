# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Vendor do
  it { should have_many(:menu_items) }

  before do
    @vendor = FactoryGirl.create(:vendor)
  end

  describe "#menu_items_order_by_popular" do
    before do
      @meal_time = FactoryGirl.create(:meal_time)
      @order = FactoryGirl.create(:order, meal_time: @meal_time)
    end

    it "has corret order" do
      menu_has_0_order = FactoryGirl.create(:menu_item, vendor: @vendor)

      menu_has_1_order = FactoryGirl.create(:menu_item, vendor: @vendor)
      FactoryGirl.create(:order_item, menu_item: menu_has_1_order, order: @order)

      menu_has_2_order = FactoryGirl.create(:menu_item, vendor: @vendor)
      FactoryGirl.create(:order_item, menu_item: menu_has_2_order, order: @order)
      FactoryGirl.create(:order_item, menu_item: menu_has_2_order, order: @order)

      menu_has_3_order = FactoryGirl.create(:menu_item, vendor: @vendor)
      FactoryGirl.create(:order_item, menu_item: menu_has_3_order, order: @order)
      FactoryGirl.create(:order_item, menu_item: menu_has_3_order, order: @order)
      FactoryGirl.create(:order_item, menu_item: menu_has_3_order, order: @order)


      @vendor.menu_items_order_by_popular.should == [
        menu_has_3_order,
        menu_has_2_order,
        menu_has_1_order,
        menu_has_0_order,
      ]
    end
  end

  describe "#menu_items_group_by_categories" do
    before do
      @category1 = FactoryGirl.create :category
      @menu_item1 = FactoryGirl.create :menu_item, category: @category1, vendor: @vendor
      @category2 = FactoryGirl.create :category
      @menu_item2 = FactoryGirl.create :menu_item, category: @category2, vendor: @vendor
      @other_cateogry = FactoryGirl.create :category
    end

    it "doesn't include other category" do
      @vendor.categories_with_menu_items.keys.include?(@other_cateogry).should be_false
    end

    it "has correct categories and menu_items" do
      categories_with_menu_items = @vendor.categories_with_menu_items

      categories_with_menu_items.keys.sort.should == [@category1.name, @category2.name].sort
      categories_with_menu_items[@category1.name]['menu_items'].should == [@menu_item1]
      categories_with_menu_items[@category2.name]['menu_items'].should == [@menu_item2]
    end
  end
end
