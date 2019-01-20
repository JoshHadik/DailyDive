class Scenes::JournalController < ApplicationController
  before_action :authenticate_user!

  def scene
    @journal = Journal.find(params[:id])
    @questions = @journal.questions.order(:id)
    @entries = @journal.entries.order(created_at: :desc)
    @new_question = Question.new
  end

  def add_question
    @journal = Journal.find(params[:id])
    @question = Question.new(question_params)
    @question.journal_id = @journal.id

    respond_to do |format|
      if @question.save
        format.js { render "scenes/journal/actions/add_question" }
      else
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:body, :journal_id)
  end
end
