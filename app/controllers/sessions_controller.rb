class SessionsController < ApplicationController
  def create
    result = Hash.new

    begin
      error = false

      username = params[:username]
      error = true if (username.nil? || username.length == 0 || username.length > 20 || !valid_username_chars(username))

      password = params[:password]
      error = true if (password.nil? || password.length == 0 || password.length > 20 || !valid_password_chars(password))

      @user = User.authenticate(username, password)
      error = true if @user.nil?

      if error
        result['status'] = 'FAILURE'
        result['error_message'] = 'Invalid username or password.'
        render :json => result and return
      end
    rescue
      logger.error "Internal server error while #{username} was trying to sign-in."
      result['status'] = 'FAILURE'
      result['error_message'] = 'Internal server error.'
      render :json => result and return
    end

    if params[:remember] == 'true'
      cookies.permanent.signed[:user_id] = @user.id
    else
      cookies.signed[:user_id] = @user.id
    end

    result['status'] = 'SUCCESS'
    render :json => result
  end

  def destroy
    cookies.delete(:user_id)
    redirect_to root_url
  end
end
