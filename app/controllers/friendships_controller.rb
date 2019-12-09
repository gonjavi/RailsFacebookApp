# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show]

  def index
    @friendships = Friendship.all
    @friendship = Friendship.new
    # @sug_users = User.left_outer_joins(:friendships)
    @suggested = User.left_outer_joins(:friendships)
    @friends2 = User.joins(:inverse_friendships).where(friendships: { confirmed: true })
    @friends = User.joins(:friendships).where(friendships: { confirmed: true })
    @users = User.all_except(current_user)
    @sug_users =  @users - @friends
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

  def confirm
    #@user = current_user.friendships.build(friendship_params)
    #@user = User.find_by(id: params[:user_id])
    @user = User.find_by(id: params[:user_id])
    current_user.confirm_friend(@user)
    flash[:success] = 'Friend Request Confirmed'
    redirect_to friendships_path
  end

  def destroy
    @friendship.destroy
  end 

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.permit(:friend_id, :confirmed, :user_id, :id)
  end

end
