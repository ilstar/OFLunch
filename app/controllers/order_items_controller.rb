class OrderItemsController < ApplicationController
  skip_before_filter :authenticate_user!
  layout :determine_layout
  set_tab :order_items

  def index
    if params.key?(:date)
      @mom = MealTime.by_date(params[:date])
    else
      @mom = MealTime.opened
    end
    @today_order_items = @mom.try(:order_items) || []
  end

  def rating
    @order_item = OrderItem.find params[:id]
    @order_item.update_attribute :rating, params[:value].to_i

    head :ok
  end

  def comment
    @order_item = OrderItem.find params[:id]
    @order_item.update_attribute :comment, params[:comment]
  end

  private
  def determine_layout
    current_user ? "application" : "blank"
  end
end
