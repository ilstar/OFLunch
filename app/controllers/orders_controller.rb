# -*- encoding : utf-8 -*-
class OrdersController < ApplicationController
  set_tab :home
  before_filter :check_mom_status_when_process_orders, only: %w(new create)

  def index
    if @today_meal_time = MealTime.today
      @today_order = @today_meal_time.orders.for_user_id(current_user.id).last

      redirect_to new_order_url if @today_meal_time.activated? and @today_order.blank?
    end

    if last_meal_time = MealTime.history.last
      @last_order = last_meal_time.orders.for_user_id(current_user.id).last
    end
  end

  def new
    @order = Order.new

    respond_to do |format|
      format.json {
        render json:
        {
          "menu_items" => MealTime.today.vendors.map {|vendor|
            {'vendor_name' => vendor.name, 'categories' => vendor.categories_with_menu_items}
          },
          "order_items" => current_user.today_order
        }
      }
      format.html
    end
  end

  def edit
    @order = current_user.orders.find params[:id]
  end

  def create
    @order = current_user.orders.build(params[:order])
    @order.meal_time = @meal_time
    if @order.save
      redirect_to orders_path, :alert => "下单成功"
    else
      redirect_to new_order_path, :alert => @order.errors.to_a.join(', ')
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

  protected

  def check_mom_status_when_process_orders
    @meal_time = MealTime.today

    if @meal_time.nil? or @meal_time.locked?
      redirect_to orders_url
    end
  end

end
