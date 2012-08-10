require 'spec_helper'

describe Admin::BalancesController do
  before do
    @admin = FactoryGirl.create :admin

    sign_in @admin
  end

  describe "GET index" do
    only_admin_can :get, 'index'
    
    it "render template successfully" do
      get :index

      response.should be_success
      assigns(:balances).should == [@admin.balance]
    end
  end
end
