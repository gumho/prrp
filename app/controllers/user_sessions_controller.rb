class UserSessionsController < ApplicationController
  # GET /user_sessions/new
  # GET /user_sessions/new.xml
  def new
    @user_session = UserSession.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /user_sessions
  # POST /user_sessions.xml
  def create
    @user_session = UserSession.new(params[:user_session])

    respond_to do |format|
      if @user_session.save
        format.html { redirect_to(role_home_path, :notice => 'Successfully logged in!') }
      elsif @user_session.attempted_record && !@user_session.attempted_record.active?
        flash[:notice] = render_to_string(:partial => 'user_sessions/not_active.erb', :locals => { :user => @user_session.attempted_record })
        format.html { render :action => "new"}
      else
        format.html { render :action => "new" }
      end
    end
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.xml
  def destroy
    @user_session = UserSession.find
    @user_session.destroy

    respond_to do |format|
      format.html { redirect_to(:root, :notice => "Successfully logged out!") }
    end
  end
end
