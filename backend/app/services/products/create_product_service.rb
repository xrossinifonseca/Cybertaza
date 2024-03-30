

module Products

  class CreateProductService

    def initialize(user)
      @user = user
    end

    def create_product(params)
      if can_create?
       product = Product.create!(params)
       return product
       end

      raise "Usuário não tem permissão para criar produtos"
    end


    private
    def can_create?
    @user.admin?
    end
  end


end
