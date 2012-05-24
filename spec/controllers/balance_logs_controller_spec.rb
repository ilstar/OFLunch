require 'spec_helper'

describe BalanceLogsController do
  before do
    @user = Factory(:user)

    sign_in @user
  end

  describe "GET index" do
    it "render" do
      get :index

      response.should be_success
    end

    it "successfully rendered with year and month" do
      get :index, year: '2012', month: '05'

      response.should be_success
    end

    it "only display current_user logs" do
      Factory(:balance_log)
      balance_logs = Factory(:balance_log, balance: @user.balance)

      get :index

      assigns(:balance_logs).should == [balance_logs]
    end
  end
end
