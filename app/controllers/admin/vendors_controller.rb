# -*- encoding : utf-8 -*-
class Admin::VendorsController < Admin::BaseController
  set_tab :vendors

  def index
    @vendors = Vendor.all
    @vendor = Vendor.new
    @meal_time = MealTime.opened

    respond_to do |format|
      format.html
    end
  end

  def create
    @vendor = Vendor.new(params[:vendor])

    respond_to do |format|
      if @vendor.save
        format.js
      else
        format.js { render 'new' }
      end
    end
  end

  def update
    @vendor = Vendor.find(params[:id])

    respond_to do |format|
      if @vendor.update_attributes(params[:vendor])
        format.json { head :no_content }
      else
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vendor = Vendor.find(params[:id])

    respond_to do |format|
      if MealTime.opened.try(:activated?) or MealTime.opened.try(:locked?)
        format.js { render js: "用户正在订餐中，无法删除商家#{@vendor.name}" }
      else
        @vendor.destroy
        format.js
      end
    end
  end
end
