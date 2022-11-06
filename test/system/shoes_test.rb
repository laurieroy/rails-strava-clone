require "application_system_test_case"

class ShoesTest < ApplicationSystemTestCase
  def setup
    @user = users(:confirmed_user_with_shoes)
    @shoe = shoes(:confirmed_user_with_shoes_shoe_2)

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
  
  test "creating a new shoe without a mileage limit" do
    visit new_shoe_path
  
    fill_in "Name",	with: "Shoe" 
    click_button "Create Shoe"

    # assert_selector "h1", text: "Shoes"
    assert_text "Shoe created"
  end

  test "rendering form errors" do
    visit new_shoe_path

    click_button "Create Shoe"

    assert_selector "#form-errors"
  end

  test "updating a shoe" do
    visit edit_shoe_path(@shoe)

    fill_in "Name",	with: "Edited Shoe"
    # check "Retired"

    click_button "Update Shoe"

    assert_text "Shoe updated"
  end

  test "deleting a shoe from edit page" do
    visit edit_shoe_path(@shoe)

    assert_difference("Shoe.count", -1) do
			accept_alert do
				click_link "Delete"
      end
    end
    assert_text "Shoe deleted"
  end
end
