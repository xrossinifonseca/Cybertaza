

module Products

  class CreateProductService

    include PermissionCheck


    def initialize(user)
      @user = user
    end

    def create_product(params)
      check_permission!(@user.role,"create")
      product = Product.create!(params)
    end
  end
end
