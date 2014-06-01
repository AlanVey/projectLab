require 'spec_helper'

describe "project_users/edit" do
  before(:each) do
    @project_user = assign(:project_user, stub_model(ProjectUser,
      :email => "MyString",
      :project_id => 1
    ))
  end

  it "renders the edit project_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", project_user_path(@project_user), "post" do
      assert_select "input#project_user_email[name=?]", "project_user[email]"
      assert_select "input#project_user_project_id[name=?]", "project_user[project_id]"
    end
  end
end
