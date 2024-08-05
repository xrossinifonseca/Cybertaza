class Product < ApplicationRecord
  belongs_to:color
  has_one_attached :image
  has_many :movements, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_one :stock, dependent: :destroy
  after_create :create_stock

  validates :name, presence: { message: "is required" }
  validates :price, numericality: { greater_than_or_equal_to: 0, message: "Price must be greater than 0" }
  validates :color_id, presence: {message: "It is necessary to inform the product color"}
  validates :code, presence: {message: "is required"}, uniqueness: true
  validates :slug, presence: {message: "is required"}, uniqueness: true



  def create_stock
    Stock.transaction do
      stock = Stock.create(quantity: 0, product_id: id)
      raise ActiveRecord::Rollback if stock.nil?
    end
  end


  scope :by_colors, ->(colors) do
    if colors.is_a?(Array) && !colors.empty?
      joins(:color).where("colors.name IN (?)", colors)
    else
      all
    end
end
end
