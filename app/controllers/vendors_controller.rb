class VendorsController < ApplicationController
  set_tab :vendor_list
  
  def index
    @vendors = Vendor.all
  end
end
