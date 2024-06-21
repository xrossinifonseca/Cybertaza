class Movement < ApplicationRecord
  belongs_to :product
  after_create :update_stock

  validates :quantity, numericality: { greater_than: 0, message: "must be greater than 0" }
  validates :product_code, presence: {message: "is required"}
  validates :date_movement, presence: {message: "is required"}
  validates :type_movement, inclusion: { in: ["entrance", "exit"] }
  validate :check_stock_quantity, if: :movement_exit?



  def movement_exit?
    type_movement == "exit"
  end


  def check_stock_quantity

    return errors.add(:product, "Product does not exist") unless product

    current_stock_quantity = product.stock.quantity
    if quantity > current_stock_quantity
      errors.add(:quantity, "The exit quantity cannot be greater than the quantity in stock")
    end
  end


  def update_stock
    entrace_product = product.movements.where(type_movement:"entrance").sum(:quantity)
    exit_product = product.movements.where(type_movement:"exit").sum(:quantity)
    quantity = entrace_product - exit_product
    product.stock.update(quantity: quantity) if product.stock
  end


end
