# -*- encoding : utf-8 -*-
class Admin::VendorsController < ApplicationController
  set_tab :vendors

  def index
    @vendors = Vendor.all
    @vendor = Vendor.new

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
    @vendor.destroy

    respond_to do |format|
      format.js
    end
  end
end
