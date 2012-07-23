# -*- encoding : utf-8 -*-
require 'spec_helper'

describe MenuItemsController do
  before do
    @admin = FactoryGirl.create :admin

    @vendor = FactoryGirl.create :vendor
    @menu_item = FactoryGirl.create :menu_item, vendor: @vendor

    sign_in @admin
  end

  describe "GET index" do
    only_admin_can :get, 'index', vendor_id: 1

    it "assigns all menu_items as @menu_items" do
      get :index, vendor_id: @vendor.to_param, format: 'js'

      response.should be_success
      assigns(:menu_items).should == [@menu_item]
      assigns(:menu_item).should be_a_new(MenuItem)
    end
  end

  describe "POST create" do
    only_admin_can :post, 'create', vendor_id: 1

    describe "with valid params" do
      it "created successfully and rendered" do
        expect {
          post :create, {menu_item: valid_attributes, vendor_id: @vendor.to_param, format: 'js'}
        }.to change(MenuItem, :count).by(1)
        response.should be_success
      end
    end

    describe "with invalid params" do
      it "re-rendere new template" do
        MenuItem.any_instance.stub(:save).and_return(false)
        post :create, {menu_item: {}, vendor_id: @vendor.to_param, format: 'js'}
        assigns(:menu_item).should be_a_new(MenuItem)
        response.should render_template('new')
      end
    end
  end

  describe "PUT update" do
    only_admin_can :put, 'update', id: 1

    describe "with valid params" do
      it "updates the attributes and rendered" do
        put :update, {id: @menu_item.to_param, menu_item: {price: '90'}, format: 'json'}

        assigns(:menu_item).price.should == 90
        response.status.should == 204
      end
    end

    describe "with invalid params" do
      it "renders json errors" do
        MenuItem.any_instance.stub(:save).and_return(false)

        put :update, {id: @menu_item.to_param, :menu_item => {}, format: 'json'}

        response.status.should == 422
      end
    end
  end

  describe "DELETE destroy" do
    only_admin_can :delete, 'destroy', vendor_id: 1, id: 1

    it "destroys the requested menu_item" do
      expect {
        delete :destroy, {id: @menu_item.to_param, vendor_id: @vendor.to_param, format: 'js'}
      }.to change(@vendor.menu_items, :count).by(-1)
      response.should be_success
    end
  end

  def valid_attributes
    FactoryGirl.build(:menu_item).attributes
  end
  
end
