class MenuItemsController < ApplicationController
  def index
    @vendor = Vendor.find params[:vendor_id]
    @menu_items = @vendor.menu_items

    respond_to do |format|
      format.js
    end
  end
end
