class PostsController < ApplicationController
  # skip_before_filter :user, :only => [:index, :show]
  
  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
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
        flash[:notice] = "Post successfully created."
      else
        flash[:notice] = "Post could not be created."
      end
      
      redirect_to posts_path
    end
  end

  # DELETE /posts/1
  def destroy
    if @user
      @post = Post.find(params[:id])
      if (@post.user_id == @user.id)
        @post.destroy 
        flash[:notice] = "Post successfully deleted."
      else
        flash[:notice] = "Post could not be deleted."
      end
    end
    
    @posts = Post.all
    render :index
  end
end
