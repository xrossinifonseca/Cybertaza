class ProductSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :image, :image_url

  def image_url
    if object.image_url.attached?
      {
        url: rails_blob_url(object.image_url)
      }
    end
  end
end
