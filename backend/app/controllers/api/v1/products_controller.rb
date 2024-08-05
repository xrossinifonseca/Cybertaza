  class Api::V1::ProductsController < Api::V1::BaseController

  # skip_before_action :authenticate_admin, only: [:index, :search,:show]

  before_action :set_product, only: [:show]
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
