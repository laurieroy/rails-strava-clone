require "test_helper"

class NotifyUsersTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:confirmed_user_with_shoes)
    @shoe = shoes(:confirmed_user_with_shoes_shoe_10)

    sign_in @user
  end

  test "notifies user when replacement_miles is reached" do
    difference = @shoe.replacement_miles - @shoe.distance_in_miles

    assert_emails 1 do
      post activities_path, params: { activity: {distance: difference, unit: "miles", user:@user, shoe:@shoe, date: Time.zone.now}}
    end
  end
end