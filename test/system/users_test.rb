require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
	test "should register" do
		visit new_user_registration_path

		assert_difference("User.count") do
			fill_in "Email", with: "unique@example.com"
			fill_in "Password", with: "password"
			fill_in "Password confirmation", with: "password"
	
			click_button "Sign up"
		end

	end
end