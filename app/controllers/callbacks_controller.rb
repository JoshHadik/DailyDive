class CallbacksController < Devise::OmniauthCallbacksController
  before_action :sign_in_from_oauth, only: [:github, :facebook]

  def github
  end

  private

  def sign_in_from_oauth
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end
end
