require "rails_helper"

RSpec.describe Api::Activities::CommentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/activites/1/commentaires").to route_to("api/activities/comments#index", activity_id: "1")
    end

    it "routes to #show" do
      expect(:get => "/api/activites/1/commentaires/1").to route_to("api/activities/comments#show", activity_id: "1", id: "1")
    end

    it "routes to #create" do
      expect(:post => "/api/activites/1/commentaires").to route_to("api/activities/comments#create", activity_id: "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/activites/1/commentaires/1").to route_to("api/activities/comments#update", activity_id: "1", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/activites/1/commentaires/1").to route_to("api/activities/comments#update", activity_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/activites/1/commentaires/1").to route_to("api/activities/comments#destroy", activity_id: "1", id: "1")
    end

  end
end
