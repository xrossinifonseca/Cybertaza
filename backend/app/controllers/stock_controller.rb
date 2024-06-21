class StockController < ApplicationController

  def index

    if !params[:search].present?
     return render json: {error:"Enter the product code"}, status: :bad_request
    end

      search = params[:search].downcase
      product_code = Product.arel_table[:code]
      product_in_stock = Stock.joins(:product).where(product_code.eq(search)).first

      if product_in_stock.nil?
        return render json: {error:"Product not found in stock"}, status: :not_found
      end


      render json: {product:product_in_stock}

    end


  def search_params
  params.require.permit(:search)
  end



end
