class PostsController < ApplicationController
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
      @post = Post.new(params[:post].merge(:user_id => @user.id))

      if @post.save
        @message = "Post successfully created."
      else
        @message = "Post could not be created."
      end
    end
  end

  # DELETE /posts/1
  def destroy
    # if @user
    #       @post = Post.find(params[:id])
    #       if (@post.user_id == @user.id)
    #         @post.destroy
    #         @message = "Post successfully deleted."
    #       else
    #         @message = "Post could not be deleted."
    #       end
    #     end

    render 'new'
  end
end
