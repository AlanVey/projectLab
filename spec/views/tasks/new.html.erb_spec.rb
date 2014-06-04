require 'spec_helper'

describe "tasks/new" do
  before(:each) do
    assign(:task, stub_model(Task,
      :name => "MyString",
      :description => "MyText",
      :user_id => 1,
      :project_id => 1,
      :difficulty => 1,
      :priority => 1
    ).as_new_record)
  end

  it "renders new task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tasks_path, "post" do
      assert_select "input#task_name[name=?]", "task[name]"
      assert_select "textarea#task_description[name=?]", "task[description]"
      assert_select "input#task_user_id[name=?]", "task[user_id]"
      assert_select "input#task_project_id[name=?]", "task[project_id]"
      assert_select "input#task_difficulty[name=?]", "task[difficulty]"
      assert_select "input#task_priority[name=?]", "task[priority]"
    end
  end
end
