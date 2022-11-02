class Activity < ApplicationRecord
  belongs_to :user

  has_one :description, class_name: 'ActionText::RichText', as: :record
  has_rich_text :description
  
  enum category: %i[run paddle hike workout race ride swim other]
  enum difficulty: %i[easy moderate hard]
  enum unit: %i[miles kilometers meters]

  before_validation :calculate_duration
  before_save :calculate_pace
  after_save :create_total
  after_destroy :subtract_from_total

  validates :date, presence: true
  validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 1, allow_nil: true }
  validates :distance, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :hours, numericality: { only_integer: true, greater_than_or_equal_to: 0,less_than_or_equal_to: 59, allow_nil: true }
  validates :minutes, numericality: { only_integer: true, greater_than_or_equal_to: 0,less_than_or_equal_to: 59, allow_nil: true }
  validates :seconds, numericality: { only_integer: true, greater_than_or_equal_to: 0,less_than_or_equal_to: 59, allow_nil: true }

  validate :require_distance_or_duration
  validate :require_unit_if_set_distance

  private 

  def calculate_duration
		calculated_duration = 0
		
		calculated_duration += self.hours * 3600 if self.hours.present?
		calculated_duration += self.minutes * 60 if self.minutes.present?
		calculated_duration += self.seconds if self.seconds.present?

		self.duration = calculated_duration unless calculated_duration == 0
	end

  def calculate_pace
		# distances are converted to miles before calculating pace
		kmConversionFactor = 0.621371
		mConversionFactor = 0.000621371

		if self.unit.present? && self.distance.present? && self.duration.present?
			case self.unit
			when "miles"
				self.calculated_pace = self.duration / self.distance

			when "kilometers"
				distance_in_miles = self.distance * kmConversionFactor
				self.calculated_pace = self.duration / (self.distance * kmConversionFactor)

			when "meters"
				distance_in_miles = self.distance * mConversionFactor
				self.calculated_pace = self.duration / (self.distance * mConversionFactor)
			end
		end
	end

  def create_total
    week = self.date.to_date.cweek
    year = self.date.to_date.cwyear
    start_date = Date.commercial(year, week)

    original_duration = self.duration
    kmConversionFactor = 0.621371
		mConversionFactor = 0.000621371

    case self.unit
    when "miles"
      distance_in_miles = self.distance

    when "kilometers"
      distance_in_miles = self.distance * kmConversionFactor


    when "meters"
      distance_in_miles = self.distance * mConversionFactor
    end

    @total = Total.find_or_initialize_by(user: self.user, start_date: start_date, range: 'week')

    total_distance = distance_in_miles + @total.distance unless distance_in_miles.nil?
    total_duration = original_duration + @total.duration unless original_duration.nil?

    @total.distance = total_distance unless total_distance.nil?
    @total.duration = total_duration unless total_duration.nil?
    @total.save
  end

  def require_distance_or_duration
    errors.add(:base, "Please add either a distance or a duration") if self.distance.nil? && self.duration.nil?
  end

  def require_unit_if_set_distance
    errors.add(:base, "Please select a unit for distance") if self.distance.present? && self.unit.nil? 
  end 

  def subtract_from_total
    week = self.date.to_date.cweek
    year = self.date.to_date.cwyear
    start_date = Date.commercial(year, week)
  
    original_duration = self.duration
    kmConversionFactor = 0.621371
		mConversionFactor = 0.000621371

    case self.unit
    when "miles"
      distance_in_miles = self.distance

    when "kilometers"
      distance_in_miles = self.distance * kmConversionFactor


    when "meters"
      distance_in_miles = self.distance * mConversionFactor
    end

    @total = Total.find_by(user: self.user, start_date: start_date, range: 'week')

    unless @total.nil?
      @total.distance -=  distance_in_miles
      @total.duration -=  original_duration
      @total.save
    end
  end
end
