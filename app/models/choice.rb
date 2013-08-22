class Choice < ActiveRecord::Base
  belongs_to :question
  validates_presence_of :option

  def percentage_calc
  	min = 0
    @vote_results = (vote_numer(self.id).to_f / vote_denom(self.question_id).to_f)*100
    return @vote_results if @vote_results > min
    return min
  end

  private
  def vote_denom(question_id)
    (Vote.where(question_id: question_id)).length
  end

  def vote_numer(choice_id)
    (Vote.where(choice_id: choice_id)).length
  end
end
