module ProposalsHelper
  def sort_link(column)
    if column == params[:sort_by]
      order = params[:order] == 'asc' ? 'desc' : 'asc'
    else
      order = 'desc'
    end
    link_to column.capitalize, :sort_by => column, :order => order
  end
end
