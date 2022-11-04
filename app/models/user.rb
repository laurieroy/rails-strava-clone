class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  
  has_many :activities, dependent: :destroy 
  has_many :shoes, dependent: :destroy 
  has_many :totals, dependent: :destroy 
end
