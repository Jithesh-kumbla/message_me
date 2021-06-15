class User < ApplicationRecord
	before_save {self.email.downcase}
	validates :first_name, presence: true, uniqueness: true, length: {minimum: 3, maximum: 20}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}
	has_secure_password

	has_many :messages, dependent: :destroy
end
