# -*- encoding : utf-8 -*-
require 'spec_helper'

describe OrdersController do
  before do
    @user = Factory(:user)
    @meal_time = Factory(:meal_time)
    @order = Factory(:order, user: @user, meal_time: @meal_time)

    sign_in @user
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
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
        other_order = Factory(:order, meal_time: @meal_time)

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
