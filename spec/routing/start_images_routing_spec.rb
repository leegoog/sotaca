require "spec_helper"

describe StartImagesController do
  describe "routing" do

    it "routes to #index" do
      get("/start_images").should route_to("start_images#index")
    end

    it "routes to #new" do
      get("/start_images/new").should route_to("start_images#new")
    end

    it "routes to #show" do
      get("/start_images/1").should route_to("start_images#show", :id => "1")
    end

    it "routes to #edit" do
      get("/start_images/1/edit").should route_to("start_images#edit", :id => "1")
    end

    it "routes to #create" do
      post("/start_images").should route_to("start_images#create")
    end

    it "routes to #update" do
      put("/start_images/1").should route_to("start_images#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/start_images/1").should route_to("start_images#destroy", :id => "1")
    end

  end
end
