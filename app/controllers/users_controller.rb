class UsersController < ApplicationController
  def show
    @posts = Post.all
  end
end
