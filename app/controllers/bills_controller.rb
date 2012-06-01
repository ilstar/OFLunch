class BillsController < ApplicationController
  def index
    if params[:year] and params[:month]
      @date = Date.civil(params[:year].to_i, params[:month].to_i)
    else
      @date = Date.today
    end

    @balance_logs = current_user.balance.balance_logs.where(created_at: (@date.beginning_of_month..@date.end_of_month + 1))
    @orders = current_user.orders.where(created_at: (@date.beginning_of_month..@date.end_of_month + 1))
    @bills = @balance_logs + @orders
  end
end
