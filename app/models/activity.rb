class Activity < ApplicationRecord
  belongs_to :user
  
  enum category: %i[run paddle hike workout race ride swim other]
  enum difficulty: %i[easy moderate hard]
  enum unit: %i[miles kilometers meters]

  before_save :calculate_pace

  validates :date, presence: true
  validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 1, allow_nil: true }
  validates :distance, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  validate :require_distance_or_duration
  validate :require_unit_if_set_distance

  private 

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

  def require_distance_or_duration
    errors.add(:base, "Please add either a distance or a duration") if self.distance.nil? && self.duration.nil?
  end

  def require_unit_if_set_distance
    errors.add(:base, "Please select a unit for distance") if self.distance.present? && self.unit.nil? 
  end
  
end
