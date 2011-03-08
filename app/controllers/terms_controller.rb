class TermsController < ApplicationController
  # auth unneeded because cancan is managing resources
  def index
    @terms = Term.paginate :page => params[:page], 
      :per_page => 20,
      :order => "begin DESC"
  end
  
  def auth
    # IMPLEMENT ME
  end
end
