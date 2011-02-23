class HomeController < ApplicationController
  def index
    render
  end
  
  def applicant_dashboard
    @current_term = current_term
  end
  
end
