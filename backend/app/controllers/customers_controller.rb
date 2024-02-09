class CustomersController < ApplicationController

  include AccessValidator


  def new
    @customers = Customer.new
  end

  def index
    isloggedin = validate(cookies)
    if isloggedin
      @customers = Customer.all
      render json: {customers: customers_without_password(@customers)}
    end
  end

  def show
    isloggedin = validate(cookies)
    if isloggedin
      if Customer.exists?(id:params[:id])
      @customers = Customer.find(params[:id])
      render json: {customer:customers_without_password(@customers)}
      else
        return render json: {error:"usuário não encontrado"}, status: :unprocessable_entity
      end
    end
  end

  def create
    begin
    Customer.transaction do
      if Customer.exists?(email:customer_params[:email])
       return render json: {error:"usuário ja cadastrado"}, status: :unprocessable_entity
      end

      @customers = Customer.create(customer_params)

      if @customers.save
        token = create_token(@customers.id)
      return  render json: {message:"usuário cadastrado com sucesso!",user:@customers,token:token}, status: :ok
    end
      render json: { error: @customers.errors.messages }, status: :unprocessable_entity
    end

    rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  private
  def customer_params
    params.permit(:name,:email,:password)
  end


  private
  def customers_without_password(customer)
     customer.as_json(except: :password_digest)
  end
end
