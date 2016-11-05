class Group < ApplicationRecord
  has_many :locations
  has_many :users, :validate => false
  
  validates :gname, :presence => true
  validates :users, :presence => true
end
