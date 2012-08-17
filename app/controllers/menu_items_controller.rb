class MenuItemsController < ApplicationController
  def index
    @categories = Category.joins(menu_items: :vendor).where("menu_items.vendor_id = ?", params[:vendor_id])


    respond_to do |format|
      format.js
    end
  end
end
