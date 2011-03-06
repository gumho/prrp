module ApplicationHelper
  def side_menu
    if !current_user
      return
    end
    
    if current_user.role.name == 'admin'
      links = {
        
      }
    elsif current_user.role.name == 'campus admin'
      links = {
        'Review' => review_proposals_path,
        'Campus Admin' => campus_control_panel_path
      }
    end
    
    render :partial => "shared/side_menu", :locals => { :links => links}
  end
  
  def current_term
    begin
      @current_term = CurrentTerm.find(1)
    rescue ActiveRecord::RecordNotFound
      return nil
    else
      return @current_term
    end
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
