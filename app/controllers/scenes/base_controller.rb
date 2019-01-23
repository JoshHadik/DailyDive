class Scenes::BaseController < ApplicationController
  layout 'scene'

  def sign_out_action
    sign_out_and_redirect(:user)
  end
end
