require 'spec_helper'

describe "project_users/new" do
  before(:each) do
    assign(:project_user, stub_model(ProjectUser,
      :email => "MyString",
      :project_id => 1
    ).as_new_record)
  end

  it "renders new project_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", project_users_path, "post" do
      assert_select "input#project_user_email[name=?]", "project_user[email]"
      assert_select "input#project_user_project_id[name=?]", "project_user[project_id]"
    end
  end
end
