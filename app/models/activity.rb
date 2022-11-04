class Activity < ApplicationRecord
  belongs_to :user
  has_one :description, class_name: 'ActionText::RichText', as: :record
  has_rich_text :description
  belongs_to :shoe, optional: true
  
  enum category: %i[run paddle hike workout race ride swim other]
  enum difficulty: %i[easy moderate hard]
  enum unit: %i[miles kilometers meters]

  before_validation :calculate_duration
  before_save :calculate_distance_in_miles
  before_save :calculate_pace
  after_save :create_or_update_total
  after_save :update_shoe_distance_in_miles
  after_destroy :create_or_update_total

  validates :date, presence: true
  validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 1, allow_nil: true }
  validates :distance, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :hours, numericality: { only_integer: true, greater_than_or_equal_to: 0,less_than_or_equal_to: 59, allow_nil: true }
  validates :minutes, numericality: { only_integer: true, greater_than_or_equal_to: 0,less_than_or_equal_to: 59, allow_nil: true }
  validates :seconds, numericality: { only_integer: true, greater_than_or_equal_to: 0,less_than_or_equal_to: 59, allow_nil: true }

  validate :require_distance_or_duration
  validate :require_unit_if_set_distance

  private 

  def calculate_distance_in_miles
    kmConversionFactor = 0.621371
		mConversionFactor = 0.000621371

		if self.unit.present? && self.distance.present?
      case self.unit
      when "miles"
        self.distance_in_miles = self.distance

      when "kilometers"
        self.distance_in_miles = self.distance * kmConversionFactor

      when "meters"
      self.distance_in_miles = self.distance * mConversionFactor
      end
    end
  end

  def calculate_duration
		calculated_duration = 0
		
		calculated_duration += self.hours * 3600 if self.hours.present?
		calculated_duration += self.minutes * 60 if self.minutes.present?
		calculated_duration += self.seconds if self.seconds.present?

		self.duration = calculated_duration unless calculated_duration == 0
	end

  def calculate_pace
		# distances are converted to miles before calculating pace

		self.calculated_pace = self.duration / self.distance_in_miles if  self.distance_in_miles.present? && self.duration.present?
	end

  def create_or_update_total
    start_date = self.date.beginning_of_week

    @total = Total.find_or_initialize_by(user: self.user, start_date: start_date, range: 'week')
    @activities = Activity.where("date >= ?", start_date)
      .where("date <= ?", start_date.end_of_week)
      .where(user: self.user)
      
    total_distance = @activities.sum(:distance_in_miles) unless @activities.empty?
    total_duration = @activities.sum(:duration) unless @activities.empty?

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

  def update_shoe_distance_in_miles
    unless self.shoe.nil?
      @activities = Activity.where(shoe: self.shoe) 
      total_distance = @activities.sum(:distance_in_miles) unless @activities.empty?

      self.shoe.update(distance_in_miles: total_distance)
    end
  end
end
