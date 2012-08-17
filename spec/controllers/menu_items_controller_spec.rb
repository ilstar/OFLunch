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

end
