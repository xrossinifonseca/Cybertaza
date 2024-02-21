class ProductsController < ApplicationController

include AccessValidator

  def index
    # isloggedin = validate(cookies)

    # if isloggedin
      @products = Product.all
      render json: {products:@products}
    # end

  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

  end

  # PATCH/PUT /products/1 or /products/1.json
  def update

  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :description)
    end
end
