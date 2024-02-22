class ProductsController < ApplicationController

include AccessValidator

  def index
      @products = Product.all
      render json: {products:@products}
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create

    is_logged_in = validate_admin(cookies)

    begin
      Product.transaction do
        create_product if is_logged_in
      end

      rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity

      rescue => e
        p e
      render json: { error: "Houve um erro interno no servidor" }, status: :internal_server_error
       end
    end


  def update
  end

  def destroy
    @product.destroy!
  end

  private

  def create_product
    @product = Product.create(product_params)

    if @product.save
      render json: { message: "Produto cadastrado com sucesso!", product: @product }, status: :ok
    else
      render json: { error: @product.errors.messages }, status: :unprocessable_entity
    end
  end

  def set_product
      @product = Product.find(params[:id])
  end

  def product_params
      params.require(:product).permit(:name, :price, :description)
  end
end
