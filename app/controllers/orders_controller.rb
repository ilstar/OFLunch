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

  def confirm
    if selected_items.blank?
      redirect_to :back, :alert => "请选择菜品"
    else
      @order = current_user.orders.build
      selected_items.each do |si|
        mi = MenuItem.find si[:id]
        @order.order_items.build(
          :price        => mi.price,
          :amount       => si[:count],
          :menu_item_id => mi.id
        )
      end
    end
  end

  def create
    @order = Order.new(params[:order])
    @order.meal_time = MealTime.today
    if @order.save
      redirect_to orders_path, :alert => "下单成功"
    else
      redirect_to new_order_path, :alert => "订餐失败， 人品太差"
    end
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

  private

  def selected_items
    params[:menu_items].select { |menu_item| menu_item[:count].to_i > 0 and menu_item[:count].to_i.to_s == menu_item[:count] }
  end
end
