class Shoe < ApplicationRecord
	has_many :activities
	belongs_to :user
	
	validates :name, presence: true
	validates :replacement_miles, numericality: {only_integer: true, greater_than_or_equal_to: 1, allow_nil: true}
	
	after_save :notify_user, if: :shoe_mileage_reached?

	private

	def notify_user 
		NotifyUserMailer.shoe_mileage_reached(self).deliver_now
		self.notified = true
	end

	def shoe_mileage_reached?
		self.replacement_miles >= self.distance_in_miles
	end

	def user_should_be_notified?
		!self.notified? && self.shoe_mileage_reached?
	end

end
