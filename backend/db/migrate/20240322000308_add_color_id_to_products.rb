class AddColorIdToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :color_id, :integer
  end
end
