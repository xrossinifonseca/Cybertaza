class Customer < ApplicationRecord
  has_one :cart
  has_secure_password

  validates :name, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence:true, length: { minimum: 6 }


end
