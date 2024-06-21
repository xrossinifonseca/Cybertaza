class AddCodeAndSlugToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :code, :string
    add_column :products, :slug, :string
    add_index :products, :code, unique: true
    add_index :products, :slug, unique: true
  end
end
