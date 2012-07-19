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
    it "success when no mom" do
      MealTime.destroy_all

      get :index

      response.should be_success
      assigns(:today_meal_time).should be_nil
    end

    it "successful render when mom created" do
      get :index

      response.should be_success
      assigns(:today_meal_time).should_not be_nil
    end

    it "successful render when order is created" do
      vendor = FactoryGirl.create(:vendor)
      menu_item = FactoryGirl.create(:menu_item, vendor: vendor)
      @meal_time.vendors << vendor
      order_item = FactoryGirl.create(:order_item, order: @order, menu_item: menu_item)

      get :index

      response.should be_success
      assigns(:today_order).should_not be_nil
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST confirm" do
    it "redirect to back when have no item selected"

    it "confirm an new order"

    it "confirm an update order"
  end

  describe "GET edit" do
    it "renders template" do
      get :edit, id: @order.to_param

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
              :user_id => @user.to_param,
              :order_items_attributes => {
                '0' => {
                  'menu_item_id' => menu_item.to_param,
                  'price' => menu_item.price.to_s,
                  'amount' => '1'
                }
              }
            }
          }

        }.should change{ OrderItem.count }.by(1)
      }.should change{ Order.count }.by(1)

      response.should redirect_to(orders_url)
    end
  end

  describe "PUT update" do
    it "have correct order items and redirect to index" do
      @order_item2 = FactoryGirl.create :order_item, order: @order, amount: 2
      @menu_item2 = @order_item2.menu_item
      @new_menu_item = FactoryGirl.create :menu_item

      put :update, :id => @order.to_param, :order => {
        :order_items_attributes => {
          '0' => {'menu_item_id' => @menu_item2.to_param, 'price' => @menu_item2.price.to_s, 'amount' => '3'},
          '1' => {'menu_item_id' => @new_menu_item.to_param, 'price' => @new_menu_item.price.to_s, 'amount' => '2'}
          }
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
