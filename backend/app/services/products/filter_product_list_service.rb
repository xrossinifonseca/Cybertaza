module Products

  class FilterProductListService



    # exemplo query url
    # api/v1/products?color%5B%5D=green&color%5B%5D=white&&price_order=lowest_price&per_page=1&page=1

    def self.by_assortment(params)
      colors = params[:color]
      price_order = params[:price_order]


      products = Product.by_colors(colors)

      case price_order
      when 'lowest_price'
      products =   products.order(price: :asc)
      when 'biggest_price'
       products = products.order(price: :desc)
      else
        products
      end

    end

  end
end
