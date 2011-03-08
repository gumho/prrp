class TermsController < ApplicationController
  
  before_filter :auth

  def index
    @terms = Term.paginate :page => params[:page], 
      :per_page => 20,
      :order => "begin DESC"
  end
  
  def activate
    term = current_term.term
    term.active = true
    if term.save
      redirect_to terms_path, :notice => 'Term was successfully activated'
    end
  end
  
  def deactivate
    term = current_term.term
    term.active = false
    if term.save
      redirect_to terms_path, :notice => 'Term was successfully de-activated'
    end
  end
  
  def auth
    authorize! :manage, :terms
  end
end
