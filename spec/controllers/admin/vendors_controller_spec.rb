# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Admin::VendorsController do
  render_views

  before do
    @user = FactoryGirl.create(:admin)
    @vendor = FactoryGirl.create(:vendor)

    sign_in @user
  end

  # This should return the minimal set of attributes required to create a valid
  # Vendor. As you add validations to Vendor, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    @vendor.attributes
  end

  describe "GET index" do
    it "assigns all vendors as @vendors" do
      get :index

      assigns(:vendors).should eq([@vendor])
      response.should be_success
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Vendor" do
        expect {
          post :create, {vendor: valid_attributes, format: 'js'}
        }.to change(Vendor, :count).by(1)
      end

      it "assigns a newly created vendor as @vendor" do
        post :create, {vendor: valid_attributes, format: 'js'}
        assigns(:vendor).should be_a(Vendor)
        assigns(:vendor).should be_persisted
      end

      it "render create.js.html" do
        post :create, {vendor: valid_attributes, format: 'js'}
        response.should render_template('create')
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved vendor as @vendor" do
        # Trigger the behavior that occurs when invalid params are submitted
        Vendor.any_instance.stub(:save).and_return(false)
        post :create, {vendor: {}, format: 'js'}
        assigns(:vendor).should be_a_new(Vendor)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Vendor.any_instance.stub(:save).and_return(false)
        post :create, {vendor: {}, format: 'js'}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested vendor as @vendor" do
        vendor = Vendor.create! valid_attributes
        put :update, {id: vendor.to_param, vendor: valid_attributes, format: 'json'}
        assigns(:vendor).should eq(vendor)
      end

      it "redirects to the vendor" do
        vendor = Vendor.create! valid_attributes
        put :update, {id: vendor.to_param, vendor: valid_attributes, format: 'json'}
        response.status.should == 204
      end
    end
  end

  describe "DELETE destroy" do
    before do
      @meal_time = FactoryGirl.create :meal_time
      @menu_item = FactoryGirl.create :menu_item, vendor: @vendor
      @order = FactoryGirl.create :order, meal_time: @meal_time
      @order_item = FactoryGirl.create :order_item, order: @order, menu_item: @menu_item
    end

    it "destroys the requested vendor" do
      @meal_time.destroy
      
      expect {
        delete :destroy, {id: @vendor.to_param, format: 'js'}
      }.to change(Vendor, :count).by(-1)
      response.should render_template('destroy')
    end

    it "can not delete when today meal time is acitvated" do
      expect {
        delete :destroy, id: @vendor.to_param, format: 'js'
      }.to change { Vendor.count }.by(0)
    end

    it "can not delete when today meal time is locked" do
      @meal_time.lock!

      expect {
        delete :destroy, id: @vendor.to_param, format: 'js'
      }.to change { Vendor.count }.by(0)
    end

    it "can delete when today meal time is closed" do
      @meal_time.close!
      
      expect {
        delete :destroy, id: @vendor.to_param, format: 'js'
      }.to change { Vendor.count }.by(-1)
    end
  end

end
