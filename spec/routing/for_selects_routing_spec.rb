require "spec_helper"

describe ForSelectsController do
  describe "routing" do

    it "routes to #index" do
      get("/for_selects").should route_to("for_selects#index")
    end

    it "routes to #new" do
      get("/for_selects/new").should route_to("for_selects#new")
    end

    it "routes to #show" do
      get("/for_selects/1").should route_to("for_selects#show", :id => "1")
    end

    it "routes to #edit" do
      get("/for_selects/1/edit").should route_to("for_selects#edit", :id => "1")
    end

    it "routes to #create" do
      post("/for_selects").should route_to("for_selects#create")
    end

    it "routes to #update" do
      put("/for_selects/1").should route_to("for_selects#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/for_selects/1").should route_to("for_selects#destroy", :id => "1")
    end

  end
end
