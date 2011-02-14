class CampusAdminControlsController < ApplicationController

  def edit
    @organization = current_user.organization
  end
  
  def update
    d = params[:deadline]
    @deadline = Date.civil(d[:year].to_i, d[:month].to_i, d[:day].to_i)
    
    @organization = Organization.where("name = ?", params[:organization]).first
    
    if @organization.update_attribute(:deadline, @deadline)
      flash[:notice] = "Successfully updated deadline!"
      redirect_to ca_path
    else
      render :action => "edit"
    end
    
  end
  
end
