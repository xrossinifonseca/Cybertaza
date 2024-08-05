class DropTablePrivileges < ActiveRecord::Migration[7.1]
  def change
    drop_table :privileges
  end
end
