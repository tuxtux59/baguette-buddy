class User < ApplicationRecord
  has_secure_password

  enum role: {admin: 1, user: 0}, _default: :user

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  validates :role, presence: true
end
