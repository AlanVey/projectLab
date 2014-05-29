require 'spec_helper'

feature 'Visitor creates a project' do
    before(:each) do
      sign_in
      @project = FactoryGirl.create(:project)
      visit url_for(@project)
    end

  scenario 'with valid params' do
    click_link 'New Project'
    fill_in 'Name', with: 'Valid name'
    fill_in 'Description', with: 'This is valid description for the project.'
    click_button 'Create Project'
    expect(page).to have_content('Project was successfully created.')
  end

  scenario 'and views it' 
  scenario 'and another user cannot edit it'

end