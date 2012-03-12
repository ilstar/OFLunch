class OrderItemsController < ApplicationController
  skip_before_filter :authenticate_user!
  layout :determine_layout

  def index
    @mom = MealTime.today
    @today_order_items = @mom.try(:order_items) || []
  end

  private
  def determine_layout
    current_user ? "application" : "blank"
  end
end
