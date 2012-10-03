require "spec_helper"

describe AdressesController do
  describe "routing" do

    it "routes to #index" do
      get("/adresses").should route_to("adresses#index")
    end

    it "routes to #new" do
      get("/adresses/new").should route_to("adresses#new")
    end

    it "routes to #show" do
      get("/adresses/1").should route_to("adresses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/adresses/1/edit").should route_to("adresses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/adresses").should route_to("adresses#create")
    end

    it "routes to #update" do
      put("/adresses/1").should route_to("adresses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/adresses/1").should route_to("adresses#destroy", :id => "1")
    end

  end
end
