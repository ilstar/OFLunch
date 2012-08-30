# -*- encoding : utf-8 -*-
class Admin::MenuItemsController < Admin::BaseController
  before_filter :load_vendor

  def index
    @menu_items = @vendor.menu_items
    @menu_item = MenuItem.new
    @categories = Category.all

    respond_to do |format|
      format.js
    end
  end

  def create
    @menu_item = @vendor.menu_items.build(params[:menu_item])
    @categories = Category.all

    respond_to do |format|
      if @menu_item.save
        format.js
      else
        format.js { render 'new' }
      end
    end
  end

  def update
    @menu_item = MenuItem.find(params[:id])

    respond_to do |format|
      if @menu_item.update_attributes(params[:menu_item])
        format.json { head :no_content }
      else
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @menu_item = MenuItem.find(params[:id])

    respond_to do |format|
      # when somebody order the dish, admin can not delete the menu item until the meal time become closed.
      if meal_time = MealTime.today and (meal_time.activated? or meal_time.locked?) and (today_order_items = @menu_item.order_items.where(["created_at > ?", Time.current.beginning_of_day])).count > 0
        format.js { render js: %{var container = $('<span class="flash-error">删除失败，因为#{today_order_items.map(&:order).map(&:user).map(&:name).join(", ")}已经订了#{@menu_item.name}</span>');container.purr();} }
      else
        @menu_item.destroy
        format.js
      end
    end
  end

  private
  def load_vendor
    @vendor = Vendor.find(params[:vendor_id]) if params.key?(:vendor_id)
  end
end
