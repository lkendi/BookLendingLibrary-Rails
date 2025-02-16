class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  enum :role, { admin: 0, user: 1 }

  has_many :borrowings
  has_many :books, through: :borrowings

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address,
              presence: { message: "is required" },
              uniqueness: { case_sensitive: false, message: "is already registered" },
              format: { with: URI::MailTo::EMAIL_REGEXP, message: "is invalid" }

  def authenticated?
    Current.session
  end
end
