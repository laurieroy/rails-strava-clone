class Shoe < ApplicationRecord
	has_many :activities, dependent: :nullify
	belongs_to :user
	
	validates :name, presence: true
	validates :replacement_miles, numericality: {only_integer: true, greater_than_or_equal_to: 1, allow_nil: true}
	
	scope :active, -> { where(retired: false) }
	scope :alphabetized, -> { order(name: :asc)}
	# I think default is by name alphabetized, so leaving off
  scope :ordered, ->  { order(retired: :asc)}
  
	def name_with_miles
		"#{self.name} (#{self.distance_in_miles} miles)"
	end
	private
end
