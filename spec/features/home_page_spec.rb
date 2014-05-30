require 'spec_helper'

feature 'User visits home page' do
  before(:each) do
    visit '/'
  end
  scenario 'and signs up' do
    sign_up_with 'email@example.com', 'ThisIsAPassword123$$$'

    current_path.should eq('/projects')
  end
end

