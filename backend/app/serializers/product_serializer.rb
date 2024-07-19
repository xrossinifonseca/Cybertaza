class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :code, :price, :color, :image_url

  def image_url
   if self.object.image.attached?
    url_for(self.object.image)
   end
  end


end





# products.map do |product|
#   {
#  id: product.id,
#  name: product.name,
#  slug:product.slug,
#  code:product.code,
#  price: product.price,
#  color: product.color,
#  image_url: product.image.attached? ? url_for(product.image) : ""
#   }
