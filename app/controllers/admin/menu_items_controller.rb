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

    respond_to do |format|
      if @menu_item.save
        @categories = Category.all
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
    @menu_item.destroy

    respond_to do |format|
      format.js
    end
  end

  private
  def load_vendor
    @vendor = Vendor.find(params[:vendor_id]) if params.key?(:vendor_id)
  end
end
