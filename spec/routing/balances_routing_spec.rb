require "spec_helper"

describe BalancesController do
  describe "routing" do

    it "routes to #index" do
      get("/balances").should route_to("balances#index")
    end

    it "routes to #new" do
      get("/balances/new").should route_to("balances#new")
    end

    it "routes to #show" do
      get("/balances/1").should route_to("balances#show", :id => "1")
    end

    it "routes to #edit" do
      get("/balances/1/edit").should route_to("balances#edit", :id => "1")
    end

    it "routes to #create" do
      post("/balances").should route_to("balances#create")
    end

    it "routes to #update" do
      put("/balances/1").should route_to("balances#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/balances/1").should route_to("balances#destroy", :id => "1")
    end

  end
end
