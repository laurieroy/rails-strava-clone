class Shoe < ApplicationRecord
	has_many :activities, dependent: :nullify
	belongs_to :user
	
	validates :name, presence: true
	validates :replacement_miles, numericality: {only_integer: true, greater_than_or_equal_to: 1, allow_nil: true}
	
	scope :active, -> { where(retired: false) }

	
  # scope :ordered, ->  { where(order('active desc'))}
  
	private


end
