  class Admin::V1::ProductsController < Admin::V1::BaseController

  before_action :set_product, only: [:destroy, :update,:show]

  include Paginable

  def index
    products  = Products::FilterProductListService.by_assortment(params)
    paginated_products = paginate(products)
    products_serialized = ActiveModelSerializers::SerializableResource.new(paginated_products, each_serializer: ProductSerializer)
    render json: { products:products_serialized, meta: pagination_meta(paginated_products)}, status: :ok
  end

  def show
      render json: {product:@product}
  end

  def search
    query = params[:search_filter]

    if query.nil?
      products = []
    else
      product_name = Product.arel_table[:name]
      products = Product.where(product_name.matches("%#{query}%")).limit(10)
    end
    render json: products, each_serializer: ProductSerializer

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
        p e.message
        handleErrorExcpetion(e)
       end
  end

  # não permitir alterar o código do produto
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
    params.permit(:name,:price,:color_id,:image,:code,:slug)
  end


  def handleErrorExcpetion(e)
    case e.message
    when "user has no permission."
      render json: { error: e.message }, status: :forbidden
    when "produto não encontrado."
      render json: { error: e.message }, status: :not_found
    else
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end
