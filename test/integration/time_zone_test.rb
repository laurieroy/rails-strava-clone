require "test_helper"

class TimeZoneTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:confirmed_user_with_time_zone)
  end

  test "sets application time_zone to equal user.time_zone" do
    sign_in @user

    get root_path

    assert_equal "Eastern Time (US & Canada)", Time.zone.name
  end
end
