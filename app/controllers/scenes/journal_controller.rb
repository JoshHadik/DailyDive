class Scenes::JournalController < Scenes::BaseController
  before_action :set_journal
  before_action :authenticate_user!
  before_action :restrict_access_to_journal_owner!

  def scene
    @questions = @journal.questions.order(:id)
    @entries = @journal.entries.order(created_at: :desc)
    @new_question = Question.new
  end

  def add_question
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

  def set_journal
    @journal = Journal.find(params[:id])
  end

  def restrict_access_to_journal_owner!
    unless @journal.owner.id == current_user.id
      redirect_to root_path, notice: "Must be signed in to #{@journal.owner.email} to access the route for this wave"
    end
  end
end
