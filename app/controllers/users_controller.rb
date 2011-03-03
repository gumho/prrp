class UsersController < ApplicationController
  
  
  def index
    authorize! :manage, :users
    
    if current_user.role.name == 'admin'
      @users = User.search(params)
    elsif current_user.role.name == 'campus admin'
      params[:user_organization_id] = current_user.organization_id
      @users = User.search(params)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    
    if can? :manage, :users
      if @user.save
        redirect_to(user_path(@user), :notice => 'User successfully created!')
      else
        render :action => "new"
      end
    else
      @user.role_id = 2 # Applicant
      
      # Saving without session maintenance to skip
      # auto-login which can't happen here because
      # the User has not yet been activated
      if @user.save_without_session_maintenance
        @user.deliver_activation_instructions!
        flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
        redirect_to root_url
      else
        render :action => :new
      end
    end    

  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def resend_activation
    if params[:login]
      @user = User.find_by_email params[:login]
      if @user && !@user.active?
        @user.deliver_activation_instructions!
        flash[:notice] = "Please check your e-mail for your account activation instructions!"
        redirect_to root_path
      end
    end
  end
  
  def require_owner_or_manage
    if (params[:user_id] == current_user.id.to_s) || (can? :manage, :users)
    else
      flash[:notice] = "You do not have access to this page"
      redirect_to user_proposals_path(current_user)  
    end
  end
end
