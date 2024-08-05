

module PermissionCheck


  def check_permission!(role,action)
  unless PermissionsAdmin::PERMISSIONS[role].include?(action)
    raise "user has no permission."
  end
  end

end
