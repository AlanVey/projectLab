require 'spec_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'valid@example.com', 'password'

    expect(page).to have_content('Log Out')
    current_path.should eq('/projects')
  end

  scenario 'with invalid email' do
    sign_up_with 'invalid_email', 'password'

    expect(page).to have_content('Email is invalid')
    current_path.should eq('/')
  end

  scenario 'with blank password' do
    sign_up_with 'valid@example.com', ''

    expect(page).to have_content('Password can\'t be blank')
    current_path.should eq('/')
  end

  scenario 'and signs out' do
    sign_up_with 'valid@example.com', 'password'
    click_link 'Log Out'

    expect(page).to have_content('Log In')
    current_path.should eq('/')
  end

  scenario 'without confirming their password' do
    visit '/'
    fill_in 'Email', with: 'email@example.com'
    fill_in 'Password', with: 'ThisIsAPassword123$$$'
    fill_in 'Password confirmation', with: ''
    click_button 'Sign up'

    current_path.should eq('/')
    expect(page).to have_content('Password confirmation doesn\'t match Password')
  end
end