class AddHexCodeToColors < ActiveRecord::Migration[7.1]
  def change
    add_column :colors, :hex_code, :string
  end
end
