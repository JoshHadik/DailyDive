module ApplicationHelper
  # def tab_card(title, &block)
  #   content_tag(:div, class: "card tabbed-card #{title}-card", &block)
  # end
  #
  # def tab(title, state=nil, &block)
  #   content_tag(:div, class: "tab #{'active' if state == :active}", &block)
  # end
  #
  # def tab_activator(title)
  #
  # end
  # <%= link_to "Github", user_github_omniauth_authorize_path, class: "github-link" %>

  def oauth_link(provider)
    title = provider.capitalize
    oauth_path = send("user_#{provider}_omniauth_authorize_path")
    link_to title, oauth_path, class: "oauth-link #{provider}-link"
  end

  def action_path(scene, *args)
    send("actions_#{scene}_path", *args)
  end

  def scene_path(scene, *args)
    send("scenes_#{scene}_path", *args)
  end


  def render_prop(prop, **locals)
    render(partial: "#{params[:controller]}/props/#{prop}", locals: locals)
  end


end
