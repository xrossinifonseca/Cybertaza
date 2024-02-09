class CustomersController < ApplicationController

  def index
    @customers = Customer.all
    render json: @customers
  end


  def show
    @customers = Customer.find(params[:id])
    render json:@customers
  end

  def new
    @customers = Customer.new
  end

  def create

    begin
    Customer.transaction do

      if Customer.exists?(email:customer_params[:email])
       return render json: {error:"usuário ja cadastrado"}, status: :unprocessable_entity
      end
      @customer = Customer.create(customer_params)

      if @customer.save
        token = create_token(@customer.id)
      return  render json: {message:"usuário cadastrado com sucesso!",user:@customer,token:token}, status: :ok

    end

      render json: { error: @customer.errors.messages }, status: :unprocessable_entity
    end

    rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  private
  def customer_params
    params.permit(:name,:email,:password)
  end



end
