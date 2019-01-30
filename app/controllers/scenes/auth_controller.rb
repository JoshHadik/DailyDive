class Scenes::AuthController < SceneController
  before_action :redirect_if_user_signed_in

  def scene
    @user = User.new
  end

  def signup
    @user = User.new(user_params)
    if @user.save
      sign_in_and_redirect(@user)
    else
      render_update(:sign_up_failed)
    end
  end

  def login
    @user = User.find_for_authentication(email: user_params[:email])

    if @user && !@user.new_record? && @user.valid_password?(user_params[:password])
      sign_in_and_redirect(@user)
    else
      @user = User.new(user_params)
      render_update(:sign_in_failed)
    end
  end

  # private
  # # Never trust parameters from the scary internet, only allow the white list through.
  # def question_params
  #   params.require(:question).permit(:body, :journal_id)
  # end

  private

  def redirect_if_user_signed_in
    redirect_to('/') if user_signed_in?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:password, :email, :password_confirmation)
  end
end
