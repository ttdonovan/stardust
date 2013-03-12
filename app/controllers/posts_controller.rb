class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    
    if !@posts.empty?
      @states = State.all
      @cities = City.all
    
      @posts.each do |post|		  
        post.username = User.find(post.user_id).username rescue 'deleted'
		    post.time_left = get_time_left(post.created_at + post.duration.minutes)
  			post.city_and_state = "#{@cities[post.city_id].name}, #{@states[post.state_id].name}"
  		end
		end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    
    states = State.all
    cities = City.all
    
    @post.username = User.find(@post.user_id).username
    @post.time_left = get_time_left(@post.created_at + @post.duration.minutes)
    @post.city_and_state = "#{cities[@post.city_id].name}, #{states[@post.state_id].name}"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    if @user
      @post = Post.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @post }
      end
    end
  end

  # GET /posts/1/edit
  def edit
    if @user
      @post = Post.find(params[:id])
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    if @user
      @post = Post.new(params[:post])
      @post.user_id = @user.id

      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render json: @post, status: :created, location: @post }
        else
          format.html { render action: "new" }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    if @user
      @post = Post.find(params[:id])

      respond_to do |format|
        if @post.update_attributes(params[:post])
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if @user
      @post = Post.find(params[:id])
      @post.destroy if (@post.user_id == @user.id)
      
      # delete from cache

      respond_to do |format|
        format.html { redirect_to posts_url }
        format.json { head :no_content }
      end
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
