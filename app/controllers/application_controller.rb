class ApplicationController < ActionController::Base
  before_filter :user

  def user
    user_id = cookies.signed[:user_id]

    if (!user_id.nil?)
      begin
        @user = User.find(user_id)
      rescue
        cookies.delete(:user_id)
      end
    end

    @user
  end

  def get_states
    result = Hash.new

    begin
      states = State.all

      result['status'] = 'SUCCESS'
      result['states'] = states
    rescue
      result['status'] = 'FAILURE'
    end

    render :json => result
  end

  def get_cities
    result = Hash.new

    begin
      cities = City.get_all_cities_in_cache(params[:state_id].to_i)

      result['status'] = 'SUCCESS'
      result['cities'] = cities
    rescue
      result['status'] = 'FAILURE'
    end

    render :json => result
  end

  def valid_username_chars(username)
    # regex = /^[a-zA-Z0-9_]*$/
    # username.match regex
    return true
  end

  def valid_password_chars(password)
    return true
  end
end
