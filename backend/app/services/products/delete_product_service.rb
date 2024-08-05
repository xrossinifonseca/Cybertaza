


module Products

  class DeleteProductService

    include PermissionCheck

    def initialize(user)
      @user = user
    end

    def delete_product(product)
        check_permission!(@user.role,"delete")
        product.destroy
    end


  end
end
