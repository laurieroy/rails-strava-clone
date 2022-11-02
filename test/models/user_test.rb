require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "unique@example.com", password: "password", password_confirmation: "password")
    @user_with_activities = users(:confirmed_user_with_activities)
    @user_with_totals = users(:confirmed_user_with_totals)
  end

  test "should be valid" do
    assert@user.valid?
  end

 test "should have default value of UTC for timezone" do
    @user.save
    assert_equal "UTC", @user.reload.time_zone
  end

  test "deletes associated activities" do
    count = @user_with_activities.activities.count
    
    assert_difference("Activity.count", -count) do
      @user_with_activities.destroy
    end
  end

  test "deletes associated totals" do
    count = @user_with_totals.totals.count

    assert_difference("Total.count", -(count)) do
      @user_with_totals.destroy
    end
  end
end
