class User < ApplicationRecord
	validates :email, :password, :presence => true
	validates :email, :uniqueness => { :case_sensitive => false }
end
