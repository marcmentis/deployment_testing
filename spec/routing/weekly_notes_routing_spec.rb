require "spec_helper"

describe WeeklyNotesController do
  describe "routing" do

    it "routes to #index" do
      get("/weekly_notes").should route_to("weekly_notes#index")
    end

    it "routes to #new" do
      get("/weekly_notes/new").should route_to("weekly_notes#new")
    end

    it "routes to #show" do
      get("/weekly_notes/1").should route_to("weekly_notes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/weekly_notes/1/edit").should route_to("weekly_notes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/weekly_notes").should route_to("weekly_notes#create")
    end

    it "routes to #update" do
      put("/weekly_notes/1").should route_to("weekly_notes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/weekly_notes/1").should route_to("weekly_notes#destroy", :id => "1")
    end

  end
end
