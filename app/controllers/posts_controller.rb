class PostsController < ApplicationController
  # skip_before_filter :user, :only => [:index, :show]
  
  # GET /posts
  def index
    @posts = Post.all
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

      if @post.save
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render action: "new"
      end
    end
  end

  # DELETE /posts/1
  def destroy
    if @user
      @post = Post.find(params[:id])
      # @post.destroy if (@post.user_id == @user.id)
      puts "******************************************* KILL **************************************************"
      
      # delete from cache
    end
    
    render :json => 'ok' 
  end
end
