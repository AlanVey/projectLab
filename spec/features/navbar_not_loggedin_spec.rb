require 'spec_helper'

feature 'View a page with the navbar' do

  scenario 'click log in' do
    visit '/'
    click_link 'Log In'
    current_path.should eq('/sign_in')
  end

  scenario 'navigate to root page' do
    visit '/'
    click_link 'Log In'
    click_link 'Pjmanagement'
    current_path.should eq('/')
  end
end