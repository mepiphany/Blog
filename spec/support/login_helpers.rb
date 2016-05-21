module LoginHelpers

  def signin(user)
    request.cookies[:auth_token] = user.auth_token
  end

end
