# -*- encoding : utf-8 -*-
class OrdersController < ApplicationController
  set_tab :home
  
  def index
    @today_meal_time = MealTime.today
    @today_order = @today_meal_time.orders.for_user_id(current_user.id).last if @today_meal_time
  end

  def new
    @order = Order.new
  end

  def edit
    @order = current_user.orders.find params[:id]
  end

  def create
    @order = current_user.orders.build(params[:order])
    @order.meal_time = MealTime.today
    if @order.save!
      redirect_to orders_path, :alert => "下单成功"
    else
      redirect_to new_order_path, :alert => "订餐失败， 人品太差"
    end
  end

  def update
    @order = current_user.orders.find params[:id]

    Order.transaction do
      @order.order_items.destroy_all
      @order.order_items_attributes = params[:order][:order_items_attributes]
      @order.save
    end

    redirect_to orders_url
  end

  def destroy
    @order = current_user.orders.find(params[:id])
    if @order.meal_time.unlock?
      @order.destroy
      message = t('delete_successfully')
    else
      message = t('order.cannot_delete_locked_order')
    end

    redirect_to orders_url, :alert => message
  end

end
