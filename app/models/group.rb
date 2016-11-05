class Group < ApplicationRecord
  has_many :locations
  has_and_belongs_to_many :users, :validate => false
  
  validates :gname, :presence => true#, uniqueness: {scope: :user}
  validates :users, :presence => true
end
