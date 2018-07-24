class RenamePermissioninUerstoRoleId < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :permission
    add_reference :users, :role, foreign_key: true
  end
end
