require 'rails_helper'

RSpec.describe "api/activities/new", type: :view do
  before(:each) do
    assign(:api_activity, Api::Activities::Comment.new())
  end

  it "renders new api_activity form" do
    render

    assert_select "form[action=?][method=?]", api_activities_comments_path, "post" do
    end
  end
end
