require "test_helper"

class TotalTest < ActiveSupport::TestCase
  def setup
    @user = users(:confirmed_user)
    @total = @user.totals.build(start_date: Time.zone.now, range: 'week')
  end
  
  test "should be valid" do
    assert @total.valid?
  end

  test "should have a start_date" do
    @total.start_date = nil
    assert_not @total.valid?
  end

  test "should have a range value" do
    @total.range = nil
    assert_not @total.valid?
  end

  test "should be unique across user, start_date and range" do
    @total.save
    @duplicate_total = @user.totals.build(start_date: Time.zone.now, range: 'week')

    assert_not @duplicate_total.valid?
  end
end
