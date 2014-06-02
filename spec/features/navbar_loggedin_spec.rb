require 'spec_helper'

feature 'View a page with the navbar when signed in' do
    before(:each) do
      @user = sign_in
      visit '/'
    end

  scenario 'and log out' do
    click_link 'Log Out'
    current_path.should eq('/')
  end

  scenario 'and click name to visit profile' do
    click_link @user.email
    fill_in 'Password', with: 'abcdefghijklmnop'
    fill_in 'Password confirmation', with: 'abcdefghijklmnop'
    fill_in 'Current password', with: @user.password
    click_button 'Update'

    current_path.should eq(projects_path)
  end

  scenario 'and navigate to root page' do
    click_link @user.email
    click_link "Pjmanagement"

    current_path.should eq('/projects')
  end

  scenario 'and check overview and edit links appear' do
    create_project

    expect(page).to have_content('Overview')
    expect(page).to have_content('Edit')
  end

  scenario 'and click overview' do
    create_project
    @prev_path = current_path

    click_link 'Overview'
  
    current_path.should eq(@prev_path)
  end

  # Add code when OT finishes his part
  scenario 'and click edit (Octavians implementation)' 

end