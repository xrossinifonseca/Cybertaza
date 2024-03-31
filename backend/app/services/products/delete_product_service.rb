


module Products

  class DeleteProductService

    def initialize(user)
      @user = user
    end

    def delete_product(id)
      raise "Usuário sem permissão." if !has_permission?
      product = Product.find_by(id: id)
      raise "produto não encontrado." if  product.nil?
      product.destroy
    end


    private
    def has_permission?
      PermissionsAdmin::PERMISSIONS[@user.role].include?("delete")
    end
  end
end
