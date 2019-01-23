class Scenes::CurrentJournalController < Scenes::BaseController
  before_action :authenticate_user!

  def scene
    @questions = current_journal.ordered_questions
    @entries = current_journal.entries.order(created_at: :desc)
    @new_question = Question.new
  end

  def add_question
    # @question = Question.new(question_params)
    # @question.journal_id = current_journal.id
    if current_journal.create_question(question_params)
      render_update(:question_added)
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  def delete_question
    @question = Question.find(params[:id])
    @question.destroy
  end

  private
  def question_params
    params.require(:question).permit(:body, :journal_id)
  end
end
