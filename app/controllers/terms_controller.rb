class TermsController < ApplicationController
  
  before_filter :auth, :only => [:index]
  def index
    @terms = Term.paginate :page => params[:page], 
      :per_page => 20,
      :order => "begin DESC"
  end
  
  def auth
    authorize! :manage, :terms
  end
end
