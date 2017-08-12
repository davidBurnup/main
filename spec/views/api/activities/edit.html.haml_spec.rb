require 'rails_helper'

RSpec.describe "api/activities/edit", type: :view do
  before(:each) do
    @api_activity = assign(:api_activity, Api::Activity.create!())
  end

  it "renders the edit api_activity form" do
    render

    assert_select "form[action=?][method=?]", api_activity_path(@api_activity), "post" do
    end
  end
end
