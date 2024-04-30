class ProductsController < ApplicationController

  skip_before_action :authenticate_admin, only: [:index]
  before_action :set_product, only: [:destroy, :update,:show]

  def index
    @products  = Products::FilterProductListService.filter_product(params[:assortment]).page(params[:page]).per(params[:per_page])
    total_pages = @products.total_pages
    product_list = @products.map do |product|
        if product.image.attached?
          { id: product.id, name: product.name,price:product.price,color:product.color, image_url: url_for(product.image) }
        else
          { id: product.id, name: product.name,price:product.price,color:product.color, image_url: ""  }
        end
    end
      render json: {products: product_list,total_pages: total_pages}
  end

  def show
    # @image_url = rails_blob_path(@product.image, only_path: true)
    render json: url_for(@product.image)
  end


  def create
    begin
        Product.transaction do
        product = Products::CreateProductService.new(@current_user).create_product(product_params)
        render json: { message: "Produto cadastrado com sucesso!", product: product }, status: :created
        end
      rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
      rescue => e
        handleErrorExcpetion(e)
       end
  end

  def update
    begin
      Product.transaction do
        product = Products::UpdateProductService.new(@current_user).update_product(@product,product_params)
        render json: {message:"Produto atualizado com sucesso!"}, status: :ok
      end
    rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
    rescue => e
    handleErrorExcpetion(e)
    end
  end

  def destroy
    begin
        Product.transaction do
          product = Products::DeleteProductService.new(@current_user).delete_product(@product)
          render json: { message: "Produto removido com sucesso!", product: product }, status: :ok
        end
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    rescue => e
      handleErrorExcpetion(e)
    end
  end


  private
  def set_product
    begin
      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: {error:"produto não encontrado"}, status: :not_found
    end

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
end
