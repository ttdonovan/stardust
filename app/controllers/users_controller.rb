class UsersController < ApplicationController
  def username_exists
    begin
      username = params[:username]

      if username.nil? or username.length == 0
        render :text => 'Please specify a username.' and return
      end

      if username.length > 20
        render :text => 'Username is too long.' and return
      end

      if !valid_username_chars username
        render :text => 'Please use only alphanumeric characters.' and return
      end

      if User.exists?(['username = ?', username])
        render :text => "#{username} already exists." and return
      end
    rescue
      render :text => 'Internal server error.' and return
    end

    render :text => "#{username} is available."
  end

  def create
    result = Hash.new

    begin
      username = params[:username]
      if username.nil? or username.length == 0
        result['status'] = 'FAILURE'
        result['error_message'] = 'Please specify a username.'
        render :json => result and return
      end

      if username.length > 20
        result['status'] = 'FAILURE'
        result['error_message'] = 'Username is too long.'
        render :json => result and return
      end

      if !valid_username_chars username
        result['status'] = 'FAILURE'
        result['error_message'] = 'Please only use alphanumeric and the underscore characters.'
        render :json => result and return
      end

      password = params[:password]
      if password.nil? or password.length == 0
        result['status'] = 'FAILURE'
        result['error_message'] = 'Please specify a password.'
        render :json => result and return
      end

      if password.length > 20
        result['status'] = 'FAILURE'
        result['error_message'] = 'Password is too long.'
        render :json => result and return
      end

      if !valid_password_chars(password)
        result['status'] = 'FAILURE'
        result['error_message'] = 'Invalid password character(s).'
        render :json => result and return
      end

      retype_password = params[:retype_password]
      if (retype_password != password)
        result['status'] = 'FAILURE'
        result['error_message'] = "Confirmation password does not equal password."
        render :json => result and return
      end

      if User.exists?(['username = ?', username])
        result['status'] = 'FAILURE'
        result['error_message'] = "#{username} already exists."
        render :json => result and return
      end

      user = User.create(:username => username, :password => password)

      logger.info "Created new user #{username}"
    rescue
      logger.error "Internal server error while trying to create new user #{username}"
      result['status'] = 'FAILURE'
      result['error_message'] = 'Internal server error.'
      render :json => result and return
    end

    if params[:remember] == 'true'
      cookies.permanent.signed[:user_id] = user.id
    else
      cookies.signed[:user_id] = user.id
    end
    session[:user_id] = user.id

    result['status'] = 'SUCCESS'
    render :json => result
  end
end
