class User < ApplicationRecord
  enum role: [:member,:admin]
  has_secure_password
end
