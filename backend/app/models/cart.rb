class Cart < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  before_create :check_if_customer_already_has_cart

  def total
    cart_items.sum {|item| item.total}
  end


  private

  def check_if_customer_already_has_cart
    if customer.present? && Cart.find_by(customer_id: customer.id)
      throw(:abort)
    end
  end


end
