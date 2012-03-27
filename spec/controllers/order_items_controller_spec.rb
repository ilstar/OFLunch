require 'spec_helper'

describe OrderItemsController do
  render_views

  before do
    @user = Factory(:user)

    sign_in @user
  end

  describe "GET 'index'" do
    before do
      @meal_time = Factory(:meal_time)
      vendor = Factory(:vendor)
      menu_item = Factory(:menu_item, vendor: vendor)
      @meal_time.vendors << vendor
      order = Factory(:order, user: @user, meal_time: @meal_time)
      order_item = Factory(:order_item, order: order, menu_item: menu_item)
      other_order = Factory(:order, meal_time: @meal_time)
      order_item = Factory(:order_item, order: other_order, menu_item: menu_item)
    end

    it "success when have no mom" do
      MealTime.destroy_all

      get 'index'

      response.should be_success
    end

    it "success when meal_time have't locked" do
      get :index

      response.should be_success
      assigns(:today_order_items).count.should == 2
    end

    it "render when meal_time is locked" do
      @meal_time.lock!

      get :index

      response.should be_success
    end

    it "render when meal_time is close" do
      @meal_time.close!

      get :index

      response.should be_success
    end

    it "successful render when visit old meal_time by date" do
      t = Time.parse('2012-03-03 12:00:00')
      meal_time = nil
      Timecop.freeze(t) do
        meal_time = Factory(:meal_time)
      end

      get :index, date: '2012-03-03'

      response.should be_success
      assigns(:mom).should == meal_time
    end
  end

end
