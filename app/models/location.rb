class Location < ApplicationRecord
  belongs_to :group

  validates :group, presence: true
end
