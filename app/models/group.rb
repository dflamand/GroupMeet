class Group < ApplicationRecord
  has_many :locations
  has_and_belongs_to_many :users, :validate => false

  def g_name
    "#{gname}"
  end

  validates :gname, :presence => true, :length => {maximum: 30}#, uniqueness: {scope: :user}
  validates :users, :presence => true
end
