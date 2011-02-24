class CommentsController < ApplicationController
  def create
    @comment = Comment.create(params[:comment])
    if @comment.save
      redirect_to(user_proposal_path(params[:comment][:user_id], params[:comment][:proposal_id]), :notice => 'Proposal was successfully created.')
    else
      render :action => "new"
    end
  end

end
