require 'spec_helper'

feature 'User creates a project' do
    before(:each) do
      sign_in
      @project = FactoryGirl.build(:project)
    end

  scenario 'with valid params and automotically views it' do
    create_project @project.name, @project.description

    expect(page).to have_content('Project was successfully created.')
    current_path.should match(/\/projects\/[0-9]+/)
  end

  scenario 'and another user cannot edit it' do
    create_project @project.name, @project.description
    click_link 'Log Out'
    sign_up_with 'second_user@gmail.com', '1234567899'

    expect(page).to have_no_content(@project.name)
  end

end