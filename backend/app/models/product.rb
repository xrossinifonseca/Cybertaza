class Product < ApplicationRecord
  belongs_to:color
  has_one_attached :image

  validates :name, presence: { message: "O nome é obrigatório" }
  validates :price, numericality: { greater_than_or_equal_to: 0, message: "preço deve ser maior ou igual a zero" }
  validates :color_id, presence: {message: "Necesário informar cor do produto"}

  # validates :description, presence: { message: "O nome é obrigatório" }

#   def imageUrl
#     Rails.application.routes.url_helpers.url_for(image) if image.attached?
#  end

end
