# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show]

  def index
    @friendships = User.all
    @friendship = Friendship.new
    @sug_users = User.all
    @suggested = User.all
  end

  def new
    @friendship = Friendship.new
  end    

  def edit; end

  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.user_id = current_user.id
    respond_to do |format|
      if @friendship.save
        format.html { redirect_to friendships_path, notice: 'Friendship request sent' }
      else
        format.html { render 'posts/index' }
        flash.now[:danger] = 'Invalid request'
      end
    end
  end

 

  def destroy
  end 

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.permit(:friend_id, :confirmed, :user_id)
  end

end
