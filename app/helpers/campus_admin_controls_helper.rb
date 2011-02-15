module CampusAdminControlsHelper
  def organization_combo_box
    if current_user.role.name == "admin"
      select_tag(:organization, options_for_select(Organization.all.collect {|p| [ p.name ] }))
    else
      select_tag(:organization, options_for_select([[current_user.organization.name]]))
    end
  end
end
