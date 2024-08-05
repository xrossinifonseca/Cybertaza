class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  before_save :check_quantity_product_in_stock


  validates :cart, presence: { message: "is required" }
  validates :product, presence: { message: "is required" }
  validates :quantity, presence: { message: "is required" }, numericality: { greater_than: 0, message: "must be greater than 0" }
  validate :check_quantity_product_in_stock


 def total
    product.price * quantity
 end



 def check_quantity_product_in_stock


   if self.product.present?
      product_in_stock =  Stock.find_by(product_id: product.id)
   end

   if product_in_stock.nil?

      errors.add(:base, "Product is not available in stock")

   elsif self.quantity > product_in_stock.quantity


      errors.add(:base, "Quantity requested exceeds stock available")

    end

 end







end
