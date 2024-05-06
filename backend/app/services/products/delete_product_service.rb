


module Products

  class DeleteProductService

    def initialize(user)
      @user = user
    end

    def delete_product(product)
      raise "Usuário sem permissão." if !has_permission?
      product.destroy
    end


    private
    def has_permission?
      PermissionsAdmin::PERMISSIONS[@user.role].include?("delete")
    end
  end
end
