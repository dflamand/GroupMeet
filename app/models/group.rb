class Group < ApplicationRecord
  has_many :locations
  has_many :users
  
  validates :gname, presence: true
end
