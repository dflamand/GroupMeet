class Invite < ApplicationRecord
  belongs_to :user
  
  validates :user_id, :presence => true
  validates :group_id, :presence => true
  validates :gname, :presence => true
end
