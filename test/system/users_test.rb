require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
	include Devise::Test::IntegrationHelpers

	def setup
		@user = users(:confirmed_user)
	end

	test "can register" do
		visit new_user_registration_path

		assert_difference("User.count") do
			fill_in "Email Address", with: "unique@example.com"
			fill_in "Password", with: "password"
			fill_in "Confirm Password", with: "password"
	
			click_button "Sign up"
		end
	end

	test "user can sign in" do
		visit new_user_session_path

		fill_in "Email Address", with: @user.email
		fill_in "Password", with: "password"

		click_button "Sign in"

		assert_selector "p", text: "Signed in successfully"
	end

	# test "user can sign out" do
	# 	sign_in @user
	# 	visit root_path

	# 	click_button "Sign out"

	# 	assert_selector "p", text: "Signed out successfully"
	# end

	test "user can update time zone" do
		sign_in @user
		visit edit_user_registration_path

		select "Hawaii"
		fill_in "Current Password", with: "password"
		click_button

		assert_equal "Hawaii", @user.reload.time_zone
		
	end


end