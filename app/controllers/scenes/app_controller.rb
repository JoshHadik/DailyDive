class Scenes::AppController < ApplicationController
  before_action :authenticate_resource_user!

  def journal
    @journal = Journal.find(params[:id])
    @questions = @journal.questions.order(:id)
    @new_question = Question.new
  end

  def my_journals
    @journals = current_resource_user.journals
    @new_journal = Journal.new
  end
end
