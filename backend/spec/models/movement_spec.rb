require 'rails_helper'

RSpec.describe Movement, type: :model do

  before do
    color = Color.first
    @product = Product.create!(name:"cyber teste",price:10,color_id:color.id)
    @movement = Movement.new
  end



  it 'is valid with valid attributes' do

    @movement.quantity = 200
    @movement.type_movement = "entrance"
    @movement.product_id = @product.id
    @movement.date_movement = DateTime.now

    @movement.save
    expect(@movement).to be_valid
  end


  it " is not valid  if exit movement type is greater than quantity in stock" do

    @movement.quantity = 200
    @movement.type_movement = "exit"
    @movement.product_id = @product.id
    @movement.date_movement = DateTime.now

    @movement.save

    expect(@movement).not_to be_valid
  end

  it 'raises an ActiveRecord::RecordInvalid error when saving an invalid type_movement' do
    @movement.quantity = 200
    @movement.type_movement = "invalid"
    @movement.product_id = @product.id
    @movement.date_movement = DateTime.now

    expect { @movement.save! }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Type movement is not included in the list')
  end


  it 'must update stock when adding new movement' do

    @movement.quantity = 50
    @movement.type_movement = "entrance"
    @movement.product_id = @product.id
    @movement.date_movement = DateTime.now
    @movement.save

    expect(@product.stock.quantity).to equal(50)

  end



end
