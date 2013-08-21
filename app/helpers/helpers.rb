helpers do
  def find_taken_surveys(user_id)
    @surveys = Vote.where(user_id: user_id).pluck('survey_id') 
    @surveys.map { |id| Survey.find_by_id(id).title }
  end

  def find_untaken_surveys(user_id)
    all_surveys = Survey.all
    taken_surveys = @surveys.map { |id| Survey.find_by_id(id) }
    return all_surveys - taken_surveys
  end
end
