  class Api::V1::CustomersController < Api::V1::BaseController

    skip_before_action :authenticate_customer, only: [:create]


  def create
    begin
    new_customer = Customer.create!(customer_params)
    create_customer_token(new_customer.id)
    render json: {message:"customer registered successfully", customer: CustomerSerializer.new(new_customer)}, status: :created
    rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def customer_data
    render json: @current_customer, serializer: CustomerSerializer
  end

  private
  def customer_params
    params.permit(:name,:email,:password)
  end


end
