require 'rails_helper'

RSpec.describe "Api::Activities", type: :request do
  describe "GET /api_activities" do
    it "works! (now write some real specs)" do
      get api_activities_path
      expect(response).to have_http_status(200)
    end
  end
end
