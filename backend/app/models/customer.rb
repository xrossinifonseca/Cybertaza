class Customer < ApplicationRecord
  has_one :cart
  has_secure_password

  validates :name, presence: { message: "O nome é obrigatório" }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP,message:"Email inválido" }
  validates :password, presence: { message: "A senha é obrigatória" }, length: { minimum: 6, message: "A senha deve ter pelo menos 6 caracteres" }


end
