require 'spec_helper'

describe MessagesController do
  before do
    @user = FactoryGirl.create :user
    @message = FactoryGirl.create :message, recipient: @user

    sign_in @user
  end

  describe "PUT 'redirect'" do
    it "mark message as read" do
      @message.read?.should be_false

      put :redirect, id: @message.to_param, redirect_to: "/orders"

      assigns(:message).read?.should be_true
    end

    it "redirect to the url" do
      put :redirect, id: @message.to_param, redirect_to: "/orders"

      response.should redirect_to("/orders") 
    end
  end

  describe "PUT ignore" do
    it "mark as read" do
      @message.read?.should be_false

      put :ignore, id: @message.to_param, format: :js

      assigns(:message).read?.should be_true
    end
  end

end
