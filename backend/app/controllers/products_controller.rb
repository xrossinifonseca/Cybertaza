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
    begin
      if is_user_logged_in?
        user = is_user_logged_in?
        Product.transaction do
        product = Products::CreateProductService.new(user).create_product(product_params)
        render json: { message: "Produto cadastrado com sucesso!", product: product }, status: :created
        end
      end
      rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
      rescue => e
        handleErrorExcpetion(e)
       end
  end

  def update
    begin
    if is_user_logged_in?
      user = is_user_logged_in?
      Product.transaction do
        product = Products::UpdateProductService.new(user).update_product(params[:id]).update!(product_params)
        render json: {message:"Produto atualizado com sucesso!"}, status: :ok
      end
    end

    rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
    rescue => e
    handleErrorExcpetion(e)
    end
  end

  def destroy
    begin
      if is_user_logged_in?
        user = is_user_logged_in?
        Product.transaction do
          product = Products::DeleteProductService.new(user).delete_product(params[:id])
          render json: { message: "Produto removido com sucesso!", product: product }, status: :ok
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    rescue => e
      handleErrorExcpetion(e)
    end
  end

  private

  def set_product
      @product = Product.find(params[:id])
  end

  def product_params
    params.permit(:name,:price,:color_id,:image)
  end


  def handleErrorExcpetion(e)

    case e.message
    when "Usuário sem permissão."
      render json: { error: e.message }, status: :forbidden
    when "produto não encontrado."
      render json: { error: e.message }, status: :not_found
    else
      render json: { error: "Houve um erro interno no servidor" }, status: :internal_server_error
    end

  end

  def is_user_logged_in?
    check_login = validate_admin(cookies)

    if check_login
     return user = User.find(check_login["user_id"])
    end
  end

end
