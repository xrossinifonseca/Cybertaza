class Product < ApplicationRecord
  belongs_to:color
  has_one_attached :image
  has_many :movements, dependent: :destroy
  has_one :stock, dependent: :destroy
  after_create :create_stock

  validates :name, presence: { message: "O nome é obrigatório" }
  validates :price, numericality: { greater_than_or_equal_to: 0, message: "preço deve ser maior ou igual a zero" }
  validates :color_id, presence: {message: "Necesário informar cor do produto"}


    def create_stock
      Stock.create(quantity:0,product_id:id,)
    end


  scope :by_colors, ->(colors) do
    if colors.is_a?(Array) && !colors.empty?
      joins(:color).where("colors.name IN (?)", colors)
    else
      all
    end
end
end



# def create_stock
#   Stock.transaction do
#     stock = Stock.create(quantity: 0, product_id: id)
#     raise ActiveRecord::Rollback if stock.nil? # Rollback if stock creation fails
#   end
# end
