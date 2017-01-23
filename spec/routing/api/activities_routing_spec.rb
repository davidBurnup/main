require "rails_helper"

RSpec.describe Api::ActivitiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/activities").to route_to("api/activities#index")
    end

    it "routes to #new" do
      expect(:get => "/api/activities/new").to route_to("api/activities#new")
    end

    it "routes to #show" do
      expect(:get => "/api/activities/1").to route_to("api/activities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/api/activities/1/edit").to route_to("api/activities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/api/activities").to route_to("api/activities#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/activities/1").to route_to("api/activities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/activities/1").to route_to("api/activities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/activities/1").to route_to("api/activities#destroy", :id => "1")
    end

  end
end
