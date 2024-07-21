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

  it "should show the total amount cart" do



  end




end
