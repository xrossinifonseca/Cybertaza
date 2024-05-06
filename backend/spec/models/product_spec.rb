require 'rails_helper'

RSpec.describe Product, type: :model do

    before do
    @color =  Color.create(name:"black",hex_code:"#000")
    end


  it 'is valid with valid attributes' do
    product = Product.new(
      name: 'product',
      price: 10,
      color_id:@color.id
    )

    product.save

    expect(product).to be_valid
  end

  it 'is not valid with price less than 0' do

    product = Product.new(
      name: 'product',
      price: -1,
      color_id:@color.id
    )

    product.save
    expect(product).not_to be_valid
  end


  it 'is not valid if color does not exist' do
    product = Product.new(
      name: 'product',
      price: 10,
      color_id: 10
    )

    product.save
    expect(product.errors.messages[:color]).to include("must exist")
  end

  it 'is not valid with empty filds' do

    product = Product.new(
      name: 'product',
      price: '',
      color_id:''
    )
    product.save
    expect(product).not_to be_valid
  end

end
