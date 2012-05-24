# -*- encoding : utf-8 -*-

class BalanceLogsController < ApplicationController
  def create
    @balance_log = BalanceLog.new(params[:balance_log])
    @balance = @balance_log.balance
    @balance.amount += @balance_log.amount

    if @balance_log.save && @balance.save
      flash.notice = "成功为#{@balance.user.identifier}充值#{@balance_log.amount}元"
    else
      flash.notice = "为#{@balance.user.identifier}充值失败" + ", #{@balance_log.errors.messages[:amount].join(",") }"
    end

    redirect_to balances_path
  end
end
