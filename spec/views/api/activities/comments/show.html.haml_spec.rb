require 'rails_helper'

RSpec.describe "api/activities/show", type: :view do
  before(:each) do
    @api_activity = assign(:api_activity, Api::Activities::Comment.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
