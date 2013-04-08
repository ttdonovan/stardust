class ApplicationController < ActionController::Base

  def valid_username_chars(username)
    # regex = /^[a-zA-Z0-9_]*$/
    # username.match regex
    return true
  end

  def valid_password_chars(password)
    return true
  end

private

  def current_user
    @current_user ||= warden.user
  end
  helper_method :current_user

  def warden
    env['warden']
  end

end
