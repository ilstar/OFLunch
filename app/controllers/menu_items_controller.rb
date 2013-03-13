class MenuItemsController < ApplicationController
  def index
    vendor = Vendor.find params[:vendor_id]
    @categories_with_menu_items = vendor.categories_with_menu_items

    respond_to do |format|
      format.js
    end
  end

  def today
    @menu_items = MenuItem.today

    respond_to do |format|
      format.json { render json: @menu_items }
    end
  end

end
