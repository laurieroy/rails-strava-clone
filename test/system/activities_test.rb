require "application_system_test_case"

class ActivitiesTest < ApplicationSystemTestCase
	def setup
		@user = users(:confirmed_user_with_activities)
		@activity = @user.activities.last
	end

	test "creates activity and calculates pace" do
		sign_in @user

		visit new_activity_path

		fill_in "Distance",	with: "10.0" 
		select "Miles"
		fill_in "Hours",	with: "1" 
		fill_in "Minutes",	with: "10" 
		fill_in "Seconds",	with: "0" 

		click_button "Create Activity"

		assert_selector "p", text: "00:07:00"
	end

	test "updates activity" do
		sign_in @user

		visit edit_activity_path(@activity)

		fill_in "Distance",	with: "320.11" 
		select "Meters"

		click_button "Update Activity"

		assert_text "Activity was updated"
	end

	test "deletes activity" do
		sign_in @user

		visit edit_activity_path(@activity)

		assert_difference("Activity.count", -1) do
			accept_alert do
				click_link "Delete"
			end
			sleep 1
    end

		assert_text "Activity deleted"
	end

	test "renders form errors" do
		sign_in @user

		visit new_activity_path

		click_button "Create Activity"
				
		assert_text "error"
	end
end