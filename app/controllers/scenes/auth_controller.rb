class Scenes::AuthController < Scenes::BaseController
  def scene
    @user = User.new
  end

  def sign_up
  end

  def sign_in
  end

  # private
  # # Never trust parameters from the scary internet, only allow the white list through.
  # def question_params
  #   params.require(:question).permit(:body, :journal_id)
  # end
end
