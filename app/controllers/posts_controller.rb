class PostsController < ApplicationController
  before_action :require_login, only: %i[new create]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def require_login
    return if user_signed_in?

    flash[:error] = 'You must be logged in to create posts.'
    redirect_to new_user_session_path
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
