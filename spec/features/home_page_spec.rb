require 'spec_helper'

feature 'User visits home page' do
  before(:each) do
    visit '/'
  end
  scenario 'and signs up' do
    fill_in 'Email', with: 'email@example.com'
    fill_in 'Password', with: 'ThisIsAPassword123$$$'
    fill_in 'Password confirmation', with: 'ThisIsAPassword123$$$'
    click_button 'Sign up'

    expect(page).to have_content('Listing projects')
  end
end