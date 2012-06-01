# -*- encoding : utf-8 -*-
class MenuItemsController < ApplicationController
  before_filter :get_vendor

  def index
    @menu_items = @vendor.menu_items

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @menu_items }
    end
  end

  def new
    @menu_item = @vendor.menu_items.build(params[:menu_item])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @menu_item = @vendor.menu_items.build(params[:menu_item])

    respond_to do |format|
      if @menu_item.save
        format.html { redirect_to new_vendor_menu_item_url(@vendor), notice: 'Menu item was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @menu_item = MenuItem.find(params[:id])

    respond_to do |format|
      if @menu_item.update_attributes(params[:menu_item])
        format.html { redirect_to vendor_menu_items_path(@vendor), notice: 'Menu item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @menu_item = MenuItem.find(params[:id])
    @menu_item.destroy

    respond_to do |format|
      format.html { redirect_to vendor_menu_items_url(@menu_item.vendor_id) }
      format.json { head :no_content }
    end
  end

  private
  def get_vendor
    @vendor = Vendor.find(params[:vendor_id]) if params.key?(:vendor_id)
  end
end
