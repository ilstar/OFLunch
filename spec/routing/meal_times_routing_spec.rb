require "spec_helper"

describe MealTimesController do
  describe "routing" do

    it "routes to #index" do
      get("/meal_times").should route_to("meal_times#index")
    end

    it "routes to #new" do
      get("/meal_times/new").should route_to("meal_times#new")
    end

    it "routes to #show" do
      get("/meal_times/1").should route_to("meal_times#show", :id => "1")
    end

    it "routes to #edit" do
      get("/meal_times/1/edit").should route_to("meal_times#edit", :id => "1")
    end

    it "routes to #create" do
      post("/meal_times").should route_to("meal_times#create")
    end

    it "routes to #update" do
      put("/meal_times/1").should route_to("meal_times#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/meal_times/1").should route_to("meal_times#destroy", :id => "1")
    end

  end
end
