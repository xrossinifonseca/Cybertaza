require 'rails_helper'

RSpec.describe Cart, type: :model do

  before do
    @cart = Cart.new
    @customer = Customer.create!(name:"test",email:"test@teste.com",password:"123teste")

  end


  it "should create a cart if customer has not a cart" do
    @cart.customer = @customer
    @cart.save
    expect(@cart).to be_valid

  end

  it "should create an anonymous cart" do

    cart = Cart.create!
    cart_2 = Cart.create!
    cart_3 = Cart.create!


    expect(cart).to be_valid
    expect(Cart.count).to eq(3)

  end

  it "should not create a cart if customer has already a cart" do

    Cart.create!(customer: @customer)

    cart_2 = Cart.new(customer: @customer)
    expect(cart_2.save).to be_falsey
    expect(Cart.count).to eq(1)

  end

  # it "should show the total amount cart" do

  #  cart =  Cart.create!(customer: @customer)

  #   color = Color.create!(name:"white",hex_code:"#fff")
  #   product = Product.create!(name:"test product",slug:"test-product",price:10,code:"#2222",color:color)
  #   product_2 = Product.create!(name:"test product 2",slug:"test-product-2",price:20,code:"#22221",color:color)

  #  CartItem.create!(product:product,quantity:1,cart:cart)
  #  CartItem.create!(product:product_2,quantity:1,cart:cart)

  #  expect(cart.total).to eq(30)
  # end



end
