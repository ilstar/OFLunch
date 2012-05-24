require 'spec_helper'

describe BillsController do

  before do
    @user = Factory(:user)

    sign_in @user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'

      response.should be_success
    end

    it "successfully rendered with balance_logs and orders" do
      Factory(:balance_log, balance: @user.balance)
      meal_time = Factory(:meal_time)
      order = Factory(:order, meal_time: meal_time, user: @user)
      order_item = Factory(:order_item, order: order)

      get :index

      assigns(:balance_logs).should_not be_empty
      assigns(:orders).should_not be_empty
      response.should be_success
    end

    it "successfully rendered with year and month" do
      get :index, year: '2012', month: '05'

      response.should be_success
    end
  end

end
