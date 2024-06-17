class CreateStock < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.integer :quantity
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
