require 'rails_helper'

RSpec.describe Customer, type: :model do

    before do
      @customer = Customer.new
    end


  it 'must be valid with valid attributes' do
    customer = Customer.new({name:"test",email:"test@test.com",password:"passwordtest"})
    expect(customer).to be_valid
  end

  it 'is not valid with invalid email' do

      @customer.name = 'test'
      @customer.email = 'invalid email'
      @customer.password = 'passwordtest'
      expect(@customer).not_to be_valid

  end


  it 'is not valid with a invalid password' do

    @customer.name = 'test'
    @customer.email = 'test@teste.com'
    @customer.password = '123'

    expect(@customer).not_to be_valid
  end

  it 'is not valid if email already exist' do

    Customer.create({name: "first customer", email: "test@email.com", password: "passwordtest"})
    second_customer = Customer.new({name: "second customer", email: "test@email.com", password: "passwordtest"})

    second_customer.save

    expect(second_customer).not_to be_valid

    expect(second_customer.errors[:email]).to include("has already been taken")
  end



end
