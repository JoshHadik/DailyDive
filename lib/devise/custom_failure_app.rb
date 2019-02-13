class CustomFailureApp < Devise::FailureApp
  def route(scope)
    :scenes_auth_path
  end
end
