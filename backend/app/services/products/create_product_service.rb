

module Products

  class CreateProductService

    def initialize(user)
      @user = user
    end

    def create_product(params)
      raise "Usuário sem permissão." if !has_permission?
       product = Product.create!(params)
    end


    private
    def has_permission?
      PermissionsAdmin::PERMISSIONS[@user.role].include?("create")
    end
  end
end
