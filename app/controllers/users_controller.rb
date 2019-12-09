class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by(id: params[:format])
    @posts = Post.all.order('created_at DESC').all
    @comments = Comment.all.order('created_at ASC').all
    @post = Post.new
    @comment = Comment.new
    @like = Like.new
    @likes = Like.all
  end

  def index
  end
end
