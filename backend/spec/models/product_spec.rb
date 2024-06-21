require 'rails_helper'

RSpec.describe Product, type: :model do

    before do
    @color =  Color.create(name:"black",hex_code:"#000")
    end


  it 'is valid with valid attributes' do
    product = Product.new(
      name: 'product',
      price: 10,
      color_id:@color.id,
      code:"p510",
      slug:"cyber"
    )

    product.save

    expect(product).to be_valid
  end

  it 'is not valid with price less than 0' do

    product = Product.new(
      name: 'product',
      price: -1,
      color_id:@color.id,
      code:"p510",
      slug:"cyber"
    )

    product.save
    expect(product).not_to be_valid
  end


  it 'is not valid if color does not exist' do
    product = Product.new(
      name: 'product',
      price: 10,
      color_id: 10,
      code:"p510",
      slug:"cyber"
    )

    product.save
    expect(product.errors.messages[:color]).to include("must exist")
  end

  it 'is not valid with invalid attribute' do
    product = Product.new(
      name: '',
      price: 10,
      color_id: @color.id,
      code:"",
      slug:""
    )

    product.save
    expect(product.errors.messages[:code]).to include("is required")
    expect(product.errors.messages[:slug]).to include("is required")
    expect(product.errors.messages[:name]).to include("is required")

  end


  it 'is not valid if code and slug has already been taken' do
    product_one = Product.new(
      name: 'product',
      price: 10,
      color_id: @color.id,
      code:"p510",
      slug:"product_same"
    )
    product_two = Product.new(
      name: 'product',
      price: 10,
      color_id: @color.id,
      code:"p510",
      slug:"product_same"
    )


    product_one.save
    product_two.save

    expect(product_two.errors.messages[:code]).to include("has already been taken")
    expect(product_two.errors.messages[:slug]).to include("has already been taken")

  end



  it 'is not valid with empty filds' do

    product = Product.new(
      name: 'product',
      price: '',
      color_id:'',
      code:"",
      slug:""
    )
    product.save
    expect(product).not_to be_valid
  end

end
