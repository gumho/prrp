class CommentObserver < ActiveRecord::Observer
  
  def after_create(comment)
    comments = comment.proposal.comments
    
    prrp_reviewer_count = 0
    
    comments.each do |com|
      if com.user.role.name == 'prrp reviewer'
        prrp_reviewer_count += 1
      end
    end
    
    if prrp_reviewer_count >= 3
      @p = comment.proposal
      @p.reviewed = true
      @p.save
    end

  end
  
end
