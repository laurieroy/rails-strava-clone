class Total < ApplicationRecord
  belongs_to :user

  enum range: %i[week]
end
