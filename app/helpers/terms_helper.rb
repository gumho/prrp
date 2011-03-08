module TermsHelper
  def time_progress_percentage_css(_begin, _end)
    # returns an integer representing the percentage of time passed 
    # in a term session's begin and end date
    # (today - _begin) / (_end - _begin)
    logger.debug ('--------x')
    
    total = (_end - _begin).to_i
    accumulated = (Date.today - _begin).to_f
    (accumulated.fdiv(total) * 100).to_i
  end
end
