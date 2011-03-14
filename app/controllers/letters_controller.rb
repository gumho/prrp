class LettersController < ApplicationController
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
end
