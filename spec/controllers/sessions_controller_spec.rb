require 'spec_helper'

describe SessionsController do
  before do
    @admin = FactoryGirl.create(:admin)
    @user = FactoryGirl.create :user

    sign_in @admin

    request.env["HTTP_REFERER"] = "http://goo.gl"
  end

  describe "GET index" do
    it "render successfully" do
      get :index

      response.should be_success
    end
  end

  describe "PUT change" do
    it "normal user can't access this" do
      sign_in @user

      put :change, user_id: 1

      response.status.should == 403
    end

    it "admin can change to user" do
      controller.current_user.should == @admin

      put :change, user_id: @user.to_param

      controller.session['warden.user.user.key'][1] == @user.id
      controller.original_user.should == @admin
    end

    it "admin can change back to himself" do
      put :change, user_id: @user.to_param
      put :change

      controller.current_user.should == @admin
      controller.original_user.should be_nil
    end
  end
end
