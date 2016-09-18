module ProjectsHelper
  def project_create_user?(project)
    return true if project[:user_id] == current_user.id
  end
end
