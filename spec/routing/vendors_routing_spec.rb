require "spec_helper"

describe VendorsController do
  describe "routing" do

    it "routes to #index" do
      get("/vendors").should route_to("vendors#index")
    end

    it "routes to #new" do
      get("/vendors/new").should route_to("vendors#new")
    end

    it "routes to #show" do
      get("/vendors/1").should route_to("vendors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/vendors/1/edit").should route_to("vendors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/vendors").should route_to("vendors#create")
    end

    it "routes to #update" do
      put("/vendors/1").should route_to("vendors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/vendors/1").should route_to("vendors#destroy", :id => "1")
    end

  end
end
