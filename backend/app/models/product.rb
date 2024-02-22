class Product < ApplicationRecord

  validates :name, presence: { message: "O nome é obrigatório" }
  validates :price, numericality: { greater_than_or_equal_to: 0, message: "preço deve ser maior ou igual a zero" }
  # validates :description, presence: { message: "O nome é obrigatório" }


end
