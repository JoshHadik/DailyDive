class Scenes::BaseController < ApplicationController
  layout 'scene'

  helper_method :current_journal

  def render_update(update, **locals)
    render("#{params[:controller]}/updates/#{update}", locals: locals)
  end

  def scene_path(scene, *args)
    send("scenes_#{scene}_path", *args)
  end

  def current_journal
    if current_user
      @current_journal ||= current_user.get_or_create_journal
    end
  end

  def sign_out_action
    sign_out_and_redirect(:user)
  end
end
