# -*- encoding : utf-8 -*-
require 'spec_helper'

describe HomeController do
  before do
    @user = FactoryGirl.create(:user)

    sign_in @user
  end

  describe "test messages" do
    it "messages should be empty when no message" do
      get :index

      response.should be_success
      assigns(:messages).should be_empty
    end

    it "should have a message" do
      message = FactoryGirl.create(:message, recipient: @user)

      get :index

      response.should be_success
      assigns(:messages).should == [message]
    end

    it "messages should be empty when message mark as read" do
      message = FactoryGirl.create(:message, recipient: @user)
      message.read!

      get :index

      response.should be_success
      assigns(:messages).should be_empty
    end
  end
end
