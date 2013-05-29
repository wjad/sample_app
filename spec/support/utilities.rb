# def full_title(page_title)
# 		base_title='Ruby on Rails Tutorial Sample App'
# 		if page_title.empty?
# 			base_title
# 		else 
# 			"#{base_title} | #{page_title}"
# 		end
# 	end
#The following line of code is to allow spec to access methods in app/helpers/application_helper.rb
include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well. because Capybara does allow saving cookies.
  cookies[:remember_token] = user.remember_token
end