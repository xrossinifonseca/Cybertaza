


module Products

  class UpdateProductService

    include PermissionCheck

    def initialize(user)
      @user = user
    end

    def update_product(product,params)

      check_permission!(@user.role,"update")
      product.update!(params)
    end
  end
end
