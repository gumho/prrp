class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to current_user
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    # Gets the current term
    def current_term
      @current_term = CurrentTerm.find(1)
    rescue ActiveRecord::RecordNotFound
      return @current_term.term
    end
    
    # Path for user type's home
    def role_home_path
      cu = current_user
      if cu.role.name == 'applicant'
        ad_path
      elsif cu.role.name == 'campus admin'
        review_proposals_path
      end
    end
end