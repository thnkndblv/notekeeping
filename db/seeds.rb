%w[read update own].each do |permission|
  PermissionType.find_or_create_by(permission: permission)
end
