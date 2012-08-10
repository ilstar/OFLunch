require 'spec_helper'

describe MenuItemsController do
  before do
    @user = FactoryGirl.create :user
    @vendor = FactoryGirl.create :vendor
    @menu_item = FactoryGirl.create :menu_item, vendor: @vendor

    sign_in @user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', vendor_id: @vendor.to_param, format: 'js'

      response.should be_success
    end
  end

end
