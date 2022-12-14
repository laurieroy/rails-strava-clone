class Total < ApplicationRecord
  belongs_to :user

  enum range: %i[week]

  validates :range, :start_date, presence: true
  validates :user, uniqueness: { scope: %i[start_date range]}
end
