module OmniauthHelper
  # <%= link_to "Github", user_github_omniauth_authorize_path, class: "github-link" %>

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
