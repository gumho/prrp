class HomeController < ApplicationController
  def index
    if !current_user
      render
    elsif current_user.role.name == 'campus admin'
      redirect_to ca_path
    elsif current_user.role.name == 'applicant'
      redirect_to ad_path
    else
      render
    end
  end
  
  def applicant_dashboard
    render
  end
  
end
