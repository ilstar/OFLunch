require 'spec_helper'

describe StatsController do
  before do
    @user = FactoryGirl.create :user
    @user1 = FactoryGirl.create :user
    @user2 = FactoryGirl.create :user
    @user3 = FactoryGirl.create :user

    @vendor1 = FactoryGirl.create :vendor
    @vendor2 = FactoryGirl.create :vendor

    @menu_item11 = FactoryGirl.create :menu_item, vendor: @vendor1
    @menu_item12 = FactoryGirl.create :menu_item, vendor: @vendor1
    @menu_item21 = FactoryGirl.create :menu_item, vendor: @vendor2
    @menu_item22 = FactoryGirl.create :menu_item, vendor: @vendor2

    @meal_time = FactoryGirl.create :meal_time

    @order1 = FactoryGirl.create :order, user: @user1, meal_time: @meal_time
    @order2 = FactoryGirl.create :order, user: @user2, meal_time: @meal_time

    @order_item1 = FactoryGirl.create :order_item, order: @order1, menu_item: @menu_item11
    @order_item2 = FactoryGirl.create :order_item, order: @order1, menu_item: @menu_item11
    @order_item3 = FactoryGirl.create :order_item, order: @order2, menu_item: @menu_item12

    sign_in @user
  end

  describe "GET popular_menus" do
    it "renders template" do
      get :popular_menus

      response.should be_success
    end

    it "renders correct data" do
      get :popular_menus

      assigns(:menu_items).map(&:name).should == [@menu_item11, @menu_item12].map(&:name)
    end
  end
end
