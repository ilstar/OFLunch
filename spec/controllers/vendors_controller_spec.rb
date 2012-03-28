# -*- encoding : utf-8 -*-
require 'spec_helper'

describe VendorsController do
  render_views

  before do
    @user = Factory(:user)
    @vendor = Factory(:vendor)

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
      get :index, {}
      assigns(:vendors).should eq([@vendor])
    end
  end

  describe "GET new" do
    it "assigns a new vendor as @vendor" do
      get :new, {}
      assigns(:vendor).should be_a_new(Vendor)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Vendor" do
        expect {
          post :create, {:vendor => valid_attributes}
        }.to change(Vendor, :count).by(1)
      end

      it "assigns a newly created vendor as @vendor" do
        post :create, {:vendor => valid_attributes}
        assigns(:vendor).should be_a(Vendor)
        assigns(:vendor).should be_persisted
      end

      it "redirects to the created vendor" do
        post :create, {:vendor => valid_attributes}
        response.should redirect_to(vendors_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved vendor as @vendor" do
        # Trigger the behavior that occurs when invalid params are submitted
        Vendor.any_instance.stub(:save).and_return(false)
        post :create, {:vendor => {}}
        assigns(:vendor).should be_a_new(Vendor)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Vendor.any_instance.stub(:save).and_return(false)
        post :create, {:vendor => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested vendor as @vendor" do
        vendor = Vendor.create! valid_attributes
        put :update, {:id => vendor.to_param, :vendor => valid_attributes}
        assigns(:vendor).should eq(vendor)
      end

      it "redirects to the vendor" do
        vendor = Vendor.create! valid_attributes
        put :update, {:id => vendor.to_param, :vendor => valid_attributes}
        response.should redirect_to(vendor)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested vendor" do
      vendor = Vendor.create! valid_attributes
      expect {
        delete :destroy, {:id => vendor.to_param}
      }.to change(Vendor, :count).by(-1)
    end

    it "redirects to the vendors list" do
      vendor = Vendor.create! valid_attributes
      delete :destroy, {:id => vendor.to_param}
      response.should redirect_to(vendors_url)
    end
  end

end
