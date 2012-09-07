require 'spec_helper'

describe OrderItemsController do
  render_views

  before do
    @user = FactoryGirl.create(:user)

    sign_in @user
  end

  describe "GET 'index'" do
    before do
      @meal_time = FactoryGirl.create(:meal_time)

      @vendor = FactoryGirl.create(:vendor)
      @menu_item = FactoryGirl.create(:menu_item, vendor: @vendor)

      @meal_time.vendors << @vendor

      @order = FactoryGirl.create(:order, user: @user, meal_time: @meal_time)
      @order_item = FactoryGirl.create(:order_item, order: @order, menu_item: @menu_item)
      @other_order = FactoryGirl.create(:order, meal_time: @meal_time)
      @order_item = FactoryGirl.create(:order_item, order: @other_order, menu_item: @menu_item)
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

    describe "when meal_time is closed" do
      it "renders template as normal" do
        @meal_time.close!

        get :index

        response.should be_success
      end

      it "renders template after admin deleted a vendor and a menu_item" do
        # prepare data
        # 3 people order 3 menu_items from 3 different vendors
        @vendor2 = FactoryGirl.create(:vendor)
        @menu_item2 = FactoryGirl.create(:menu_item, vendor: @vendor2)
        @vendor3 = FactoryGirl.create(:vendor)
        @menu_item3 = FactoryGirl.create(:menu_item, vendor: @vendor3)
        @meal_time.vendors << @vendor2
        @meal_time.vendors << @vendor3

        @order2 = FactoryGirl.create :order, meal_time: @meal_time
        @order_item2 = FactoryGirl.create :order_item, order: @order2, menu_item: @menu_item2
        @order3 = FactoryGirl.create :order, meal_time: @meal_time
        @order_item3 = FactoryGirl.create :order_item, order: @order3, menu_item: @menu_item3

        # delete vendor 2 and menu_item 3
        @vendor2.destroy
        @menu_item3.destroy
        @meal_time.close!

        get :index

        response.should be_success
      end
    end

    it "successful render when visit old meal_time by date" do
      t = Time.parse('2012-03-03 12:00:00')
      meal_time = nil
      Timecop.freeze(t) do
        meal_time = FactoryGirl.create(:meal_time)
      end

      get :index, date: '2012-03-03'

      response.should be_success
      assigns(:mom).should == meal_time
    end
  end

  describe "PUT rating" do
    it "rates 4 stars" do
      order_item = FactoryGirl.create :order_item
      order_item.rating.should_not == 4

      put :rating, id: order_item.to_param, value: '4'

      assigns(:order_item).rating.should == 4
    end
  end

  describe "PUT comment" do
    it "adds comments" do
      order_item = FactoryGirl.create :order_item
      order_item.comment.should be_nil
      comment = 'blabla'

      put :comment, id: order_item.to_param, comment: comment, format: 'js'

      assigns(:order_item).comment.should == comment
    end
  end

end
