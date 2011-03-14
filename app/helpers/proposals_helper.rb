module ProposalsHelper
  def sort_link(column)
    if column == params[:sort_by]
      order = params[:order] == 'asc' ? 'desc' : 'asc'
    else
      order = 'desc'
    end
    link_to column.capitalize, request.parameters.merge({:sort_by => column, :order => order})
  end
  
  def comment_author(first_name)
    if first_name
      if first_name == current_user.first_name
        'You wrote:'
      else
        "#{first_name} wrote:"
      end
    else
      'Un-name reviewer wrote:'
    end
  end
end
