require 'spec_helper'

describe MenuItemsController do
  before do
    @user = FactoryGirl.create :user

    sign_in @user
  end

  describe "GET 'index'" do
    before do
      category = FactoryGirl.create :category

      @vendor = FactoryGirl.create :vendor
      @menu_item = FactoryGirl.create :menu_item, vendor: @vendor, category: category
      menu_item_without_category = FactoryGirl.create :menu_item, vendor: @vendor
    end

    it "returns http success" do
      get 'index', vendor_id: @vendor.to_param, format: 'js'

      response.should be_success
    end
  end

  describe "GET today" do
    it "returns nothing when no menu_item" do
      get :today, format: 'json'

      response.should be_success
    end

    it "returns nothing when no menu_item today" do
      category = FactoryGirl.create :category
      @vendor = FactoryGirl.create :vendor
      @menu_item = FactoryGirl.create :menu_item, vendor: @vendor, category: category
      menu_item_without_category = FactoryGirl.create :menu_item, vendor: @vendor

      get :today, format: 'json'

      response.should be_success
    end

    it "returns data when has today meal time" do
      @meal_time = FactoryGirl.create(:meal_time)
      @order = FactoryGirl.create(:order, user: @user, meal_time: @meal_time)
      @order_item = FactoryGirl.create(:order_item, order: @order)

      get :today, format: 'json'

      assigns(:menu_items).should_not be_empty
      response.should be_success
    end
  end

end
