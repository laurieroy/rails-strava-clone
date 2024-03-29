require "test_helper"

class ShoesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_one = users(:confirmed_user_with_shoes)
    @user_two = users(:confirmed_user_with_shoe)

    @user_one_shoe =  @user_one.shoes.first
    @user_two_shoe =  @user_two.shoes.first
  end

  test "cannot delete another user's shoe" do
    skip
    sign_in @user_one

    assert_no_difference("Shoe.count") do
      delete shoe_path(@user_two_shoe)
    end 
  end

  test "cannot update another user's shoe" do
    skip
    sign_in @user_one
    new_name = "edited"

    put shoe_path(@user_two_shoe), params: { shoe: {name: new_name}}
    assert_not_equal @user_two_shoe.reload.name, new_name
  end

end
