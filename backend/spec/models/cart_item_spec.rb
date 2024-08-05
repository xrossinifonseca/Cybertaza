require 'rails_helper'

RSpec.describe CartItem, type: :model do


  before do

    color = Color.create!(name:"white",hex_code:"#fff")
    @product1 = Product.create!(name:"product 1",slug:"product-1",price:10,code:"#2222",color:color)
    @product2 = Product.create!(name:"product 2",slug:"product-2",price:10,code:"#3333",color:color)
    Movement.create!(product:@product1,quantity:10,type_movement:"entrance", product_code: @product1.code, date_movement:Date.new)
    @cart = Cart.create!(customer:nil)
  end


  describe "validations" do

    it "should throw an error if the quantity of the product exceeds the quantity of the product in the stock" do
      item = CartItem.new(cart:@cart, product: @product1,quantity:11)
      expect(item.save).to be_falsey
      expect(item.errors.messages[:base]).to include("Quantity requested exceeds stock available")

    end


    it "should throw an error if the quantity is less than 1" do

    item = CartItem.new(cart:@cart, product: @product2,quantity:0)
    expect(item.save).to be_falsey
    expect(item.errors.messages[:quantity]).to include("must be greater than 0")
  end

  it "should throw an error if the cart is not present" do

    item = CartItem.new(product: @product2,quantity:1)
    expect(item.save).to be_falsey
    expect(item.errors.messages[:cart]).to include("is required")

  end


  it "should throw an error if the product is not present" do

    item = CartItem.new(cart:@cart,quantity:1)
    expect(item.save).to be_falsey
    expect(item.errors.messages[:product]).to include("is required")

  end





  end


  describe "add item to cart" do

    it "should create an item" do
      cart_item = CartItem.create!(cart:@cart,product: @product1, quantity:2)
      expect(cart_item).to be_valid
      expect(cart_item.quantity).to eq(2)
    end




  end




end
