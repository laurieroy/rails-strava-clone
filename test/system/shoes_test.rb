require "application_system_test_case"

class ShoesTest < ApplicationSystemTestCase
  def setup
    @user = users(:confirmed_user_with_shoes)

    sign_in @user
  end
  
  test "creating a new shoe" do
    visit new_shoe_path
  
    fill_in "Name",	with: "Shoe" 
    fill_in "Notify me when my shoes hit this mileage",	with: "500" 
    click_button "Create Shoe"

    # assert_selector "h1", text: "Shoes"
    assert_text "Shoe created"
  end
end
