# -*- encoding : utf-8 -*-
class MealTimesController < ApplicationController
  def index
    @today_meal_time = MealTime.today
  end

  def new
    @meal_time = MealTime.new
  end


  def create
    @meal_time = MealTime.new(params[:meal_time])

    respond_to do |format|
      if @meal_time.save
        format.html { redirect_to meal_times_url }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def lock
    @mom = MealTime.find params[:id]
    if @mom.lock
      flash.notice = "菜单已锁定，用户无法继续点餐"
    else
      flash.notice = "菜单锁定失败"
    end
    redirect_to order_items_path
  end

  def unlock
    @meal_time = MealTime.find params[:id]
    @meal_time.unlock!

    flash.notice = "解锁成功"
    redirect_to order_items_url
  end


  def close
    @mom = MealTime.find params[:id]
    if @mom.close
      flash.notice = "菜单已关闭，扣钱成功"
    else
      flash.notice = "菜单关闭失败"
    end
    redirect_to order_items_path
  end

end
