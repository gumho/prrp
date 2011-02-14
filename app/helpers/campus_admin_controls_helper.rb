module CampusAdminControlsHelper
  def organization_combo_box
    select_tag(:organization, options_for_select(Organization.all.collect {|p| [ p.name ] }))
  end
end
