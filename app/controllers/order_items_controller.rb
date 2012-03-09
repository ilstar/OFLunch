class OrderItemsController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    @mom = MealTime.today
    @today_order_items = @mom.try(:order_items) || []
  end
end
