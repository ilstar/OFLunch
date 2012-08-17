class MenuItemsController < ApplicationController
  def index
    vendor = Vendor.find params[:vendor_id]
    @menu_items_group_category = {}
    
    vendor.menu_items.each do |menu_item|
      @menu_items_group_category[menu_item.category] ||= []
      @menu_items_group_category[menu_item.category] << menu_item
    end

    respond_to do |format|
      format.js
    end
  end
end
