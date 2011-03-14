module ApplicationHelper
  def side_menu
    if !current_user
      return
    end
    
    if current_user.role.name == 'admin'
      links = {
        
      }
    elsif current_user.role.name == 'campus admin'
      # Get number of current winners to display in side menu
      if current_term
        num_elects = CampusWinner.where("term_id = ? AND organization_id = ?", current_term.id, current_user.organization_id).count
        num_elects = '(' + num_elects.to_s + ')'
      else
        num_elects = ''
      end

        
      num_elects = 0 if (num_elects == nil)
      links = {
        'Review' => review_proposals_path,
        'Campus' => campus_control_panel_path,
        'Users' => users_path,
        "Elected #{num_elects}" => campus_winners_path
      }
    elsif current_user.role.name == 'campus reviewer'
      links = {
        'Review' => review_proposals_path
      }
    elsif current_user.role.name == 'applicant'
      links = {
        'New Proposal' => new_user_proposal_path(current_user),
        'Manage Proposals' => user_proposals_path(current_user)
      }
    elsif current_user.role.name == 'prrp admin'
      links = {
        'Terms' => terms_path,
        'Assign' => assignment_index_proposals_path,
        'Winners' => term_winners_path
      }
    elsif current_user.role.name == 'prrp reviewer'
      links = {
        'Review' => review_proposals_path
      }
    else
      links = {'' => ''}
    end
    
    render :partial => "shared/side_menu", :locals => { :links => links}
  end
  
  def current_term
      @current_term = Term.where('active = ?', true).first
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  
  def flash_helper
      f_names = [:notice, :error, :warning, :message]

      for name in f_names
        if flash[name]
          fl = "<p id=\"#{name}\">#{flash[name]}</p>".html_safe
        end
      flash[name] = nil;
    end
    return fl
  end
end
