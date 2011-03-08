module TermsHelper
  def time_progress_percentage_css(_begin, _end, today)
    # returns an integer representing the percentage of time passed 
    # in a term session's begin and end date
    (today - _begin) / (_end - _begin)
  end
end
