# spec/support/features/session_helpers.rb
module Features
  module SessionHelpers
    def sign_up_with(email, password)
      visit '/'
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password
      click_button 'Sign up'
    end

    def sign_in
      user = create(:user)
      visit '/sign_in'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      return user
    end

    def sign_out
      click_link 'Log out'
    end

    def submit_project(name = 'valid name', description = 'valid description', path = '/projects/new')
      sign_in
      visit path
      fill_in 'Name', with: name
      fill_in 'Description', with: description
      click_button 'Create Project'
    end
  end
  
end
