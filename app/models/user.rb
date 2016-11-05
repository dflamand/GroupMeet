class User < ApplicationRecord
	has_and_belongs_to_many :groups, optional:true
	
	before_save {self.email = self.email.downcase}

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

	validates :email, :presence => true, :uniqueness => { :case_sensitive => false }, :length => {maximum: 60}, :format => {with: EMAIL_REGEX}
	validates :password, :presence => true
	
	

	has_secure_password
end
