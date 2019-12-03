# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_like, only: %i[show destroy]
  before_action :authenticate_user!, except: %i[show]
    
  def new
    @like = Like.new
  end

  def create
    @like = Like.new(like_params)
    @like.user_id = current_user.id
    if @like.save
      redirect_to posts_path
    else
      flash.now[:danger] = 'Like was not created'
      redirect_to posts_path
    end
  end

  private
  
  def set_like
    @like = Like.find(params[:id])
  end

  def like_params
    params.require(:like).permit(:comment_id, :post_id)
  end
end
