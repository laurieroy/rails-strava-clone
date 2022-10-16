require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
	def setup
		@user = users(:confirmed_user)
	end

	test "should register" do
		visit new_user_registration_path

		assert_difference("User.count") do
			fill_in "Email", with: "unique@example.com"
			fill_in "Password", with: "password"
			fill_in "Password confirmation", with: "password"
	
			click_button "Sign up"
		end
	end

	test "user can sign in" do
		visit new_user_session_path

		fill_in "Email", with: @user.email
		fill_in "Password", with: @user.password

		click_button "Sign in"

		assert_selector "p", text: "Signed in successfully"
	end

	test "user can sign out" do
		visit root_path

		click_button "Sign out"

		assert_selector "p", text: "Signed out successfully"
	end
end