
class ProductsService


  def self.create_product(id)

    if User.exists?(id)
      user = User.find(id)
    end

    raise "acesso não autorizado."
  end



end
