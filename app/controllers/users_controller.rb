# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = Friendship.all
    @friendship = Friendship.new
  end

  def show
    @user = User.find_by(id: params[:format])
    @posts = Post.all.order('created_at DESC').all
    @comments = Comment.all.order('created_at ASC').all
    @post = Post.new
    @comment = Comment.new
    @like = Like.new
    @likes = Like.all
  end
end
