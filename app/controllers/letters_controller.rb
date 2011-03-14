class LettersController < ApplicationController
  
  before_filter :auth, :only => [:index]
  
  def show
    @letter = Letter.find(params[:id])
  end
  
  def destroy
    
  end
  
  def index
    @letters = Letter.paginate :page => params[:page],
      :per_page => 20,
      :order => 'applicant_last_name ASC'
  end
  
  def new
    @letter = Letter.new    
  end
  
  def create
    @letter = Letter.new(params[:letter])
    if @letter.save
      render :action => 'success'
    else
      render :action => 'new'
    end
  end
  
  def auth
    authorize! :manage, :letters
  end
end
