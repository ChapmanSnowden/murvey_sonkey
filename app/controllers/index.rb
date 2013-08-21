get '/' do
  erb :index
end

get '/user' do
  @taken_surveys = find_taken_surveys(session[:user_id])
  @created_surveys = current_user.surveys
  @untaken_surveys = find_untaken_surveys(session[:user_id])
  erb :profile
end

# ------- Creator of Survey ------

post '/survey/new'do
  @survey = Survey.create(title: params[:title], user_id: session[:user_id] )
# => Removed session[:survey_object] = @survey
  session[:survey_id] = @survey.id # added this
  erb :create_survey
end


#submit info for new survey
post '/survey' do
  # @survey = Survey.create(title: params[:title], user_id: session[:user_id] )
  @question = Question.create(survey_id: @survey.id, prompt: params[:prompt])
  
  @survey = session[:survey_id]
  @choices =[]
  @choices.push (params[:choice1])
  @choices.push (params[:choice2])
  @choices.push (params[:choice3])
  @choices.push (params[:choice4])
  

  @choices.each do |choice|
    Choice.create(question_id: @question.id, option: choice)
  end
  erb :create_survey
  # erb :_survey_components, :layout => false
end

# ------- Taker of Survey ------

#display survey to take
get '/survey/:id' do

  @survey = Survey.find(params[:id])
  @question = Question.where(survey_id: @survey.id)
  @choice = Choice.where(question_id: @question[0].id)
  erb :take_survey
end

#submit info for survey taken
post '/survey/:id' do
  p params[:choices]
 
  params[:choices].each do |question_id, choice_id|
    @vote = Vote.create(user_id: session[:user_id], survey_id: params[:survey_id], question_id: question_id, choice_id: choice_id)
  end

  redirect '/user'
end

# -------- Results --------------

get '/survey/results/:id' do
  @survey = Survey.find(params[:id])
  @questions = Question.where(survey_id: @survey.id)
  erb :results
end
