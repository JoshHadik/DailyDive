class Scenes::BaseController < ApplicationController
  layout 'scene'

  def confirm_user_owns_journal!
  end

  def sign_out_action
    sign_out_and_redirect(:user)
  end
end
