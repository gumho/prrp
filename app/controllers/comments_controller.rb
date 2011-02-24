class CommentsController < ApplicationController
  def create
    @comment = Comment.create(params[:comment])
    if @comment.save
      redirect_to(user_proposal_path(@comment.proposal.user, @comment.proposal), :notice => 'Proposal was successfully created.')
    else
      render :action => "new"
    end
  end

end
