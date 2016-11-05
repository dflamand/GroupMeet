class Group < ApplicationRecord
  has_many :locations
  has_and_belongs_to_many :users, :validate => false
  
  validates :gname, :presence => true
  validates :users, :presence => true#, :uniqueness => true
end
