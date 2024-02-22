class User < ApplicationRecord
  belongs_to :privileges

  has_secure_password


end
