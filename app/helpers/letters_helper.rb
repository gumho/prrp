module LettersHelper
  def organization_combo_box(form)
    form.select(:applicant_organization, options_for_select(Organization.all.collect {|p| [ p.name ] }))
  end
end
