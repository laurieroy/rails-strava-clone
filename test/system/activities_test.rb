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

	test "paginates activities" do
		sign_in @user

		visit activities_path

		assert_link "Next"
		assert_link "Prev"
	end

	test "searches activities based on difficulty" do
		@user = users(:confirmed_user_with_searchable_activities)
		sign_in @user

		visit activities_path

		select "Hard"

		click_button "Search"

		within ".table" do
			assert_text "hard", count: 2
			assert_text "moderate", count: 0
			assert_text "easy", count: 0
		end
	end

	test "searches reset correctly resets filters" do
		skip
		# click_link "Reset"
# 	assert_text "Please select", count: 2
		# find_field "Start date".placeholder("mm/dd/yyyy")  # figure out how to do this
		# assert_empty "End date"
	end

	# Note: I
	test "searches activities based on description" do
		@user = users(:confirmed_user_with_searchable_activities)
		sign_in @user

		visit activities_path

		fill_in "Description includes",	with: "should not yield results"
		click_button "Search"

		assert_text "No results"

		click_link "Reset"
	
		# with valid terms
		fill_in "Description includes",	with: "million"
		click_button "Search"

		within "table" do
			assert_text "hard", count: 1
			assert_text "moderate", count: 0
			assert_text "easy", count: 0
		end
	end

end