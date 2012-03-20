require 'spec_helper'

describe OrderItemsController do
  render_views

  before do
    @user = Factory(:user)

    sign_in @user
  end

  describe "GET 'index'" do
    it "success when have no mom" do
      MealTime.destroy_all

      get 'index'

      response.should be_success
    end

    it "success when some orders created" do
      meal_time = Factory(:meal_time)
      vendor = Factory(:vendor)
      menu_item = Factory(:menu_item, vendor: vendor)
      meal_time.vendors << vendor
      order = Factory(:order, user: @user, meal_time: meal_time)
      order_item = Factory(:order_item, order: order, menu_item: menu_item)
      other_order = Factory(:order, meal_time: meal_time)
      order_item = Factory(:order_item, order: other_order, menu_item: menu_item)

      get :index

      response.should be_success
      assigns(:today_order_items).count.should == 2
    end
  end

end
