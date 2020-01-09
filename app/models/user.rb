# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :name, presence: { string: true }, length: { minimum: 2 }
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array += inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact
  end

  def sug_users
    users_array = User.all - friendships.map { |friendship| friendship.friend if friendship.user_id }
    users_array -= inverse_friendships.map { |friendship| friendship.user if friendship.friend_id }
    users_array.compact
  end

  def friends_posts_and_own_posts
    posts_array = posts.map { |post| post if post.user == self }
    self.friends.each do |f|
      posts_array += f.posts
    end
    posts_array.compact
    posts_array.sort_by(&:created_at).reverse
  end

  def show_pending_friends
    pending_f_array = friendships.map { |friendship|
      friendship.friend if friendship.confirmed == false and friendship.user == self
    }
    pending_f_array.compact
  end

  def show_friendships(pending_user)
    friendships_array = friendships.map { |f| f if f.user == self and f.friend == pending_user }
    friendships_array.compact
  end

  def show_friend_requests
    f_r_array = inverse_friendships.map { |friendship| friendship.user if friendship.confirmed == false and friendship.friend == self }
    f_r_array.compact
  end

  def show_friendship_requests(user)
    fsp_array = inverse_friendships.map { |f| f if f.user == user and f.friend == self }
    fsp_array.compact
  end

  def confirm_friendship(user)
    confirm_f_array = inverse_friendships.map { |f| f if f.user == user and f.friend == self }
    confirm_f_array.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |f| (f.user == user and f.friend == self) or (f.user == self and f.friend == user) }
    friendship.confirmed = true
    friendship.save
  end
end
