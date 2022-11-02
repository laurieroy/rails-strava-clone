require "test_helper"

class ActivityTest < ActiveSupport::TestCase
  def setup
    @user = users(:confirmed_user)
    @activity = @user.activities.build(date: Time.zone.now, duration: 1)
    @kmConversionFactor = 0.6213711985
    @mConversionFactor = 0.0006213711985
  end

  test "should be valid" do
    assert @activity.valid?
  end

  test "should have a date" do
    @activity.date = nil
    assert_not @activity.valid?
  end

  test "duration should be positive" do
    @activity.duration = -1
    assert_not @activity.valid?
  
    @activity.duration = 0
    assert_not @activity.valid?
  end

  test "distance should be positive" do
    @activity.distance  = -1
    assert_not @activity.valid?
 
    # @activity.distance  = 0
    # assert_not @activity.valid?
  end

  test "has either distance or duration" do
    @activity.distance  = nil
    @activity.duration  = nil

    assert_not @activity.valid?
  end

  test "distance has unit if distance is set" do
    @activity.distance  = 1
    @activity.unit = nil

    assert_not @activity.valid?
  end

  
  test "calculates pace given a distance (miles) and duration (s)" do
    @activity.distance = 10
    @activity.unit = :miles
    @activity.duration = 3600
    @activity.save

    assert_equal 360, @activity.reload.calculated_pace
  end 


  test "calculates pace given a distance (kilometers) and duration (s)" do
    @activity.distance = 10
    @activity.unit = :kilometers
    @activity.duration = 1800
    @activity.save

    distance_in_miles = @activity.distance * @kmConversionFactor
    pace = @activity.duration / distance_in_miles

    assert_in_delta pace, @activity.reload.calculated_pace, 0.001
  end

  test "calculates pace (sec/mi) given a distance (meters) and duration (seconds)" do
    @activity.distance = 800
    @activity.unit = :meters
    @activity.duration = 180
    @activity.save

    distance_in_miles = @activity.distance * @mConversionFactor
    pace = @activity.duration / distance_in_miles

    assert_in_delta pace, @activity.reload.calculated_pace, 0.001
  end

  test "calculate duration" do
    @activity.hours = 1
    @activity.minutes = 30
    @activity.seconds = 15
    @activity.save

    assert_equal 5415, @activity.reload.duration
  end

  test "hours should be a positive integer" do
    @activity.hours = -1

    assert_not @activity.valid?
  end

  test "minutes should be between 0 and 59" do
    @activity.minutes = -1

    assert_not @activity.valid?

    @activity.minutes = 60

    assert_not @activity.valid?
  end

  test "seconds should be between 0 and 59" do
    @activity.seconds = -1

    assert_not @activity.valid?

    @activity.seconds = 60

    assert_not @activity.valid?
  end

  test "creates a total record when saved" do
    @user = users(:confirmed_user_with_time_zone)
    week = Time.zone.now.to_date.cweek
    year = Time.zone.now.to_date.cwyear
    start_date = Date.commercial(year, week)

    assert_difference "Total.count", 1 do
     7.times do |i|
        @user.activities.create(date: start_date + i.days, hours:1, minutes:0, seconds:0, unit: "miles", distance: 10)
      end
    end

    @total = @user.totals.last

    assert_equal 25200, @total.duration
    assert_equal 70, @total.distance
  end

  test "updates total record when activity is deleted" do
    @user = users(:confirmed_user_with_time_zone)
    @activity_one = @user.activities.create(date: Time.zone.now, hours:1, minutes:0, seconds:0, unit: "miles", distance: 10)
    @activity_two = @user.activities.create(date: Time.zone.now, hours:1, minutes:0, seconds:0, unit: "miles", distance: 10)
    @total = @user.totals.last

    @activity_one.destroy

    assert_equal 3600, @total.reload.duration
    assert_equal 10, @total.reload.distance
  end
end
