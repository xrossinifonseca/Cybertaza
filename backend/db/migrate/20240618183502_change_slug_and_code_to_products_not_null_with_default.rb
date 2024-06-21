class ChangeSlugAndCodeToProductsNotNullWithDefault < ActiveRecord::Migration[7.1]
  def change
    change_column :products, :slug, :string, null:false
    change_column :products, :code, :string, null:false
  end
end
