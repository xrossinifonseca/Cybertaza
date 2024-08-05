class ChangeCustomerIdInTableCartToNulWithDefault < ActiveRecord::Migration[7.1]
  def change
 change_column_null :carts, :customer_id, true

 change_column_default :carts, :customer_id, nil

 remove_foreign_key :carts, :customers, column: :customer_id
 add_foreign_key :carts, :customers, column: :customer_id
 end
end
