class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :role, :permissions

  def permissions
    PermissionsAdmin::PERMISSIONS[self.object.role]
  end


end
