class ProductsController < ApplicationController

include AccessValidator

  def index
      @products = Product.page(params[:page]).per(params[:per_page])
      total_pages = @products.total_pages

      products_with_images = @products.map do |product|
        if product.image.attached?
          { id: product.id, name: product.name,price:product.price,color:product.color, image_url: url_for(product.image) }
        else
          { id: product.id, name: product.name,price:product.price,color:product.color, image_url: ""  }
        end
      end

      render json: {products:products_with_images, total_pages:total_pages}
  end

  def show
    @product = Product.find(params[:id])
    # @image_url = rails_blob_path(@product.image, only_path: true)
    render json: url_for(@product.image)
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create

    is_logged_in = validate_admin(cookies)

    begin
      if is_logged_in
        user = User.find(is_logged_in["user_id"])

        Product.transaction do
          product = Products::CreateProductService.new(user).create_product(product_params)
          render json: { message: "Produto cadastrado com sucesso!", product: product }, status: :created
        end
      end

      rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity

      rescue => e
        if e.message == "Usuário não tem permissão para criar produtos"
          render json: { error: e.message }, status: :forbidden
        else
          render json: { error: "Houve um erro interno no servidor" }, status: :internal_server_error
        end
       end
    end



  def update
  end

  def destroy

    is_logged_in = validate_admin(cookies)

    product = set_product

    begin

      Permissions

      Product.transaction do
        if is_logged_in
          product.destroy
          render json: { message: "produto deletado com sucesso!" }, status: :ok
        end
      end


      rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity

      rescue => e
        p e
      render json: { error: e.messages }, status: :internal_server_error
       end
    end


  private

  def set_product
      @product = Product.find(params[:id])
  end

  def product_params
    params.permit(:name,:price,:color_id,:image)
  end
end
