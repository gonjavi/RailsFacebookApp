# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[show update destroy]
  before_action :authenticate_user!, except: %i[show]

  def index
    @friendships = Friendship.all
    @friendship = Friendship.new
  end

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.user_id = current_user.id
    respond_to do |format|
      if @friendship.save
        format.html { redirect_to users_path, notice: 'Friendship request sent' }
      else
        format.html { render 'posts/index' }
        flash.now[:danger] = 'Invalid request'
      end
    end
  end

  def confirm
    @user = User.find_by(id: params[:user_id])
    current_user.confirm_friend(@user)
    flash[:success] = 'Friend Request Confirmed'
    redirect_to users_path
  end

  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'Friendshid or request was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.permit(:friend_id, :confirmed, :user_id, :id)
  end
end
