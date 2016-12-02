class Group < ApplicationRecord
  has_many :locations, dependent: :delete_all
  has_and_belongs_to_many :users, :validate => false

  def g_name
    "#{gname}"
  end

  validates :gname, :presence => true, :length => {maximum: 30}#, uniqueness: {scope: :user}
  validates :users, :presence => true

  def clear_locations
  	if self.locations.count > 0
  		self.locations.delete_all
  	end
  end
end
