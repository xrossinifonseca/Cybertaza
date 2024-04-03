class ChangeUsersTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :privileges_id
    add_column :users, :role, :integer, default:0
  end
end
