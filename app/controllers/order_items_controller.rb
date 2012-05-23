class OrderItemsController < ApplicationController
  skip_before_filter :authenticate_user!
  layout :determine_layout
  set_tab :order_items

  def index
    if params.key?(:date)
      @mom = MealTime.by_date(params[:date])
    else
      @mom = MealTime.today
    end
    @today_order_items = @mom.try(:order_items) || []
  end

  private
  def determine_layout
    current_user ? "application" : "blank"
  end
end
