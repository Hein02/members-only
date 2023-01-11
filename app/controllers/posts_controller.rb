class PostsController < ApplicationController
  before_action :require_login, only: %i[new create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
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
