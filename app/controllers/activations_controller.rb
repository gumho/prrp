class ActivationsController < ApplicationController
  
  before_filter :load_user_using_perishable_token
  
  def create
    # TODO: change this to redirect to a page
    raise Exception if @user.active?

    if @user.activate!
      flash[:notice] = "Your account has been activated!"
      UserSession.create(@user, false) # Log user in manually
      @user.deliver_welcome!
      redirect_to current_user  
    else
      render :action => :new
    end
  end
  
  private
    def load_user_using_perishable_token
      @user = User.find_using_perishable_token(params[:activation_code])
      unless @user
        flash[:notice] = "We're sorry, but we could not locate your account. " +
          "If you are having issues try copying and pasting the URL " +
          "from your email into your browser or restarting the " +
          "reset password process."
        redirect_to root_url
      end
    end

end
