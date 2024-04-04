module Products

  class FilterProductListService


    def self.filter_product(params)

      case params
      when 'lowest_price'
        products = Product.order(price: :asc)
      when 'biggest_price'
        products = Product.order(price: :desc)
      else
        products = Product.all
      end
    end

  end
end
