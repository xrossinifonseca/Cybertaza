require 'rails_helper'

RSpec.describe Movement, type: :model do

  before do
    color = Color.create!(name:"red",hex_code:"#fff")
    @product = Product.create!(name:"cyber teste",price:10, color_id:color.id,code:"010p",slug:"cybver")
    @movement = Movement.new
  end


  describe 'testing validation attributes' do

  it 'is valid with valid attributes' do

    p @product.id
    @movement.quantity = 200
    @movement.type_movement = "entrance"
    @movement.product_id = @product.id
    @movement.date_movement = DateTime.now
    @movement.product_code = @product.code

    @movement.save
    expect(@movement).to be_valid
  end


  it " is not valid  if exit movement type is greater than quantity in stock" do

    @movement.quantity = 200
    @movement.type_movement = "exit"
    @movement.product_id = @product.id
    @movement.date_movement = DateTime.now
    @movement.product_code = @product.code


    @movement.save

    expect(@movement).not_to be_valid
  end

  it " is not valid  if date movement is empty" do

    @movement.quantity = 200
    @movement.type_movement = "exit"
    @movement.product_id = @product.id
    @movement.date_movement = ""
    @movement.product_code = @product.code


    @movement.save

    expect(@movement.errors.messages[:date_movement]).to include("is required")
  end


  it " is not valid  if product code is empty" do

    @movement.quantity = 200
    @movement.type_movement = "exit"
    @movement.product_id = @product.id
    @movement.date_movement = DateTime.now
    @movement.product_code = ""


    @movement.save

    expect(@movement.errors.messages[:product_code]).to include("is required")
  end


  it 'raises an ActiveRecord::RecordInvalid error when saving an invalid type_movement' do
    @movement.quantity = 200
    @movement.type_movement = "invalid"
    @movement.product_id = @product.id
    @movement.date_movement = DateTime.now
    @movement.product_code = @product.code


    expect { @movement.save! }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Type movement is not included in the list')
  end
  end

  describe 'update stock when create a new movement' do
  it 'must update stock when adding new movement' do

    @movement.quantity = 50
    @movement.type_movement = "entrance"
    @movement.product_id = @product.id
    @movement.date_movement = DateTime.now
    @movement.product_code = @product.code
    @movement.save


    expect(@product.stock.quantity).to equal(50)

  end
  end



end
