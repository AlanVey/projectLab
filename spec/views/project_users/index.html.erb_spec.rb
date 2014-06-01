require 'spec_helper'

describe "project_users/index" do
  before(:each) do
    assign(:project_users, [
      stub_model(ProjectUser,
        :email => "Email",
        :project_id => 1
      ),
      stub_model(ProjectUser,
        :email => "Email",
        :project_id => 1
      )
    ])
  end

  it "renders a list of project_users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
