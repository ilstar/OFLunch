class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def index
    @today_meal_time = MealTime.today
  end
end
