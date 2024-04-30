


module Products

  class UpdateProductService

    def initialize(user)
      @user = user
    end

    def update_product(product,params)
      raise "Usuário sem permissão." if !has_permission?

      product.update!(params)
    end


    private
    def has_permission?
      PermissionsAdmin::PERMISSIONS[@user.role].include?("update")
    end
  end
end
