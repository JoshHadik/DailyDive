module OmniauthHelper
  def oauth_link(provider)
    link_to provider.capitalize,
            oauth_path(provider),
            class: "oauth-link #{provider}-link"
  end

  private

  def oauth_path(provider)
    send("user_#{provider}_omniauth_authorize_path")
  end
end
