class Scenes::CurrentJournalController < SceneController
  before_action :authenticate_user!

  def scene
    @questions = current_journal.ordered_questions
    @entries = current_journal.entries.order(created_at: :desc)
    @new_question = Question.new
  end

  def add_question
    if @question = current_journal.create_question(question_params)
      render_update(:question_added)
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  def update_account
    if current_user.update_without_password(user_params)
      render_update(:account_update_succeeded)
    else
      render_update(:account_update_failed)
    end
  end

  def delete_account
    if valid_current_password?
      current_user.destroy
      redirect_to('/')
    else
      render_update(:delete_account_failed)
    end
  end

  def update_password
    if valid_current_password? && current_user.update(password_params)
      render_update(:password_update_succeeded)
    else
      render_update(:password_update_failed)
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

  def user_params
    params.require(:user).permit(:email)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def current_password_param
    params[:user][:current_password]
  end

  def valid_current_password?
    current_user.valid_password?(current_password_param) || incorrect_current_password!
  end

  def incorrect_current_password!
    current_user.errors[:current_password] << "is incorrect"
    false
  end
end
