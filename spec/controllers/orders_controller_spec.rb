# -*- encoding : utf-8 -*-
require 'spec_helper'

describe OrdersController do
  render_views

  before do
    @user = FactoryGirl.create(:user)
    @meal_time = FactoryGirl.create(:meal_time)
    @order = FactoryGirl.create(:order, user: @user, meal_time: @meal_time)
    @order_item = FactoryGirl.create(:order_item, order: @order)

    sign_in @user
  end

  describe "GET index" do
    it "renders template when today meal time hasn't created" do
      MealTime.destroy_all

      get :index

      response.should be_success
      assigns(:today_meal_time).should be_nil
    end

    describe "when today meal time is created" do
      it "redirects to orders#new when order hasn't created" do
        @order.destroy

        get :index

        response.should redirect_to(new_order_url)
      end

      it "renders template when today order is created" do
        vendor = FactoryGirl.create(:vendor)
        menu_item = FactoryGirl.create(:menu_item, vendor: vendor)
        @meal_time.vendors << vendor
        order_item = FactoryGirl.create(:order_item, order: @order, menu_item: menu_item)

        get :index

        response.should be_success
        assigns(:today_order).should_not be_nil
        assigns(:today_meal_time).should_not be_nil
      end
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST create" do
    it "creates order and redirect to index" do
      @order.destroy
      menu_item = FactoryGirl.create :menu_item

      lambda {
        lambda {
          post :create, {
            :order => {
              :order_items_attributes => [
                { 'menu_item_id' => menu_item.to_param, 'amount' => '1'}
              ]
            }
          }

        }.should change{ OrderItem.count }.by(1)
      }.should change{ Order.count }.by(1)

      assigns(:order).total_price.should == menu_item.price * 1
      response.should redirect_to(orders_url)
    end

    it "can't create order when doesn't pass order_items_attributes"
  end

  describe "PUT update" do
    it "have correct order items and redirect to index" do
      @order_item2 = FactoryGirl.create :order_item, order: @order, amount: 2
      @menu_item2 = @order_item2.menu_item
      @new_menu_item = FactoryGirl.create :menu_item

      put :update, :id => @order.to_param, :order => {
        :order_items_attributes => [
            {'menu_item_id' => @menu_item2.to_param, 'amount' => '3'},
            {'menu_item_id' => @new_menu_item.to_param, 'amount' => '2'}
          ]
        }

      assigns(:order).order_items.size.should == 2
      assigns(:order).total_price.should == 3 * @menu_item2.price + 2 * @new_menu_item.price

      response.should redirect_to(orders_url)
    end
  end

  describe "DELETE destroy" do
    describe "when successfully" do
      it "delete it" do
        lambda {
          delete :destroy, id: @order.id.to_s
        }.should change{ @user.orders.count }.by(-1)
      end

      it "redirect to order index page after deleted" do
        delete :destroy, id: @order.id.to_s

        response.should redirect_to(orders_url)
        controller.flash[:alert].should == I18n.t('delete_successfully')
      end
    end

    describe "when failing" do
      it "can't delete others order" do
        other_order = FactoryGirl.create(:order, meal_time: @meal_time)

        lambda {
          delete :destroy, id: other_order.id.to_s
        }.should raise_error(ActiveRecord::RecordNotFound)
      end

      it "can't delete after meal time is locked" do
        meal_time = @order.meal_time
        meal_time.lock

        lambda {
          delete :destroy, id: @order.id.to_s
        }.should change{ Order.count }.by(0)
      end

      it "redirect to index page with alert" do
        meal_time = @order.meal_time
        meal_time.lock

        delete :destroy, id: @order.id.to_s

        response.should redirect_to(orders_url)
        controller.flash[:alert].should == I18n.t('order.cannot_delete_locked_order')
      end
    end
  end

end
