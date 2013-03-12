class ApplicationController < ActionController::Base
  before_filter :user

# shouldn't I be checking pwd also?
  def user
    user_id = cookies.signed[:user_id]
        
    if (@user.nil? && !user_id.nil?)
      begin
        @user = User.find(user_id)
      rescue
        # clear out cookies
        cookies.signed[:user_id] = nil
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
      cities = City.get_all_by_state(params[:state_id])

      result['status'] = 'SUCCESS'
  		result['cities'] = cities
		rescue
	    result['status'] = 'FAILURE'
	  end
	  
    render :json => result
  end
  	
	def valid_username_chars(username)
	  return true
		# regex = /^[a-zA-Z0-9_]*$/
		# username.match regex
	end
	
	def valid_password_chars(password)
		return true
	end
end
