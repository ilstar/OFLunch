class BillsController < ApplicationController
  def index
    @balance_logs = current_user.balance.balance_logs.order('id DESC')
    @date = Date.today

    if params[:year] and params[:month]
      @date = Date.civil(params[:year].to_i, params[:month].to_i)
    else
      @date = Date.today
    end
  end
end
