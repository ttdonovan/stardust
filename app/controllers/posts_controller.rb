class PostsController < ApplicationController
  # GET /posts
  def index
    @posts = Post.all
    
    if !@posts.empty?
      @posts.each do |post|		  
        post.username = User.find(post.user_id).username rescue 'deleted'
		    post.time_left = get_time_left(post.created_at + post.duration.minutes)
  			post.city_and_state = "#{City.find(post.city_id).name}, #{State.find(post.state_id).name}"
  		end
		end
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
    
    @post.username = User.find(@post.user_id).username
    @post.time_left = get_time_left(@post.created_at + @post.duration.minutes)
    @post.city_and_state = "#{City.find(@post.city_id).name}, #{State.find(@post.state_id).name}"
  end

  # GET /posts/new
  def new
    if @user.nil?
      redirect_to posts_path
    end
  end

  # POST /posts
  def create
    if @user
      @post = Post.new(params[:post])
      @post.user_id = @user.id

      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
        else
          format.html { render action: "new" }
        end
      end
    end
  end

  # DELETE /posts/1
  def destroy
    if @user
      @post = Post.find(params[:id])
      @post.destroy if (@post.user_id == @user.id)
      
      # delete from cache
    end
  end
  
  private
  
  def get_time_left(end_time)
    time_left = ""
    
    current_time = Time.parse(Time.now.strftime('%Y-%m-%d %H:%M:%S')).utc
	  end_time = Time.parse(end_time.to_s)
    
    if (current_time > end_time)
      time_left = "This posting has ended."
    else
      time_hash = Time.diff(current_time, end_time)
	  
      minutes = time_hash[:minute]
      hours = time_hash[:hour]
  
      time_left = "Less than a minute left" if (hours == 0 && minutes == 0)
  		time_left = "#{minutes} minutes left" if (hours == 0 && minutes > 0)
  		time_left = "#{hours} hours left" if (hours > 0 && minutes == 0)
  		time_left = "#{hours} hours #{minutes} minutes left" if (hours > 0 && minutes > 0)
  	end
  	
  	return time_left
	end
end
