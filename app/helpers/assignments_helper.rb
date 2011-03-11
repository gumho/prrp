module AssignmentsHelper
  def draggable_title(user)
    "#{user.first_name} #{user.last_name} (#{user.organization.name})"
  end
end
