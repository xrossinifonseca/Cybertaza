class CreateMovements < ActiveRecord::Migration[7.1]
  def change
    create_table :movements do |t|
      t.integer :quantity, null: false
      t.references :product, null: false, foreign_key: true
      t.string :type_movement, null: false
      t.datetime :date_movement, null: false
      t.timestamps
    end

    execute <<-SQL
    ALTER TABLE movements
    ADD CONSTRAINT type_movement_check
    CHECK (type_movement IN ('entrance', 'exit'));
    SQL
  end
end
