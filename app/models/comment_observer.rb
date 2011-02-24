class CommentObserver < ActiveRecord::Observer
  
  def after_create(comment)
    if comment.proposal.reviewed == false
      @p = comment.proposal
      @p.reviewed = true
      @p.save
    end
  end
  
end
