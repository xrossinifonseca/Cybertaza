


module Products

  class UpdateProductService

    def initialize(user)
      @user = user
    end

    def update_product(id)
      raise "Usuário sem permissão." if !has_permission?
      product = Product.find_by(id: id)
      raise "produto não encontrado." if  product.nil?
      product
    end


    private
    def has_permission?
      PermissionsAdmin::PERMISSIONS[@user.role].include?("update")
    end
  end
end
