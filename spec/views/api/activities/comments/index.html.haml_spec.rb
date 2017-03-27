require 'rails_helper'

RSpec.describe "api/activities/index", type: :view do
  before(:each) do
    assign(:api_activities_comments, [
      Api::Activities::Comment.create!(),
      Api::Activities::Comment.create!()
    ])
  end

  it "renders a list of api/activities" do
    render
  end
end
