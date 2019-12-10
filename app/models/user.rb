# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :name, presence: { string: true }, length: { minimum: 2 }
  has_many :friendships
  has_many :inverse_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id'
  scope :all_except, ->(user) { where.not(id: user) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def friends
    friends_array = friendships.map{|friendship| friendship.friend if friendship.confirmed}
    friends_array += inverse_friendships.map{|friendship| friendship.user if friendship.confirmed}
    friends_array.compact
  end

  #def sug_users
   # friends_array = friendships.map{|friendship| friendship.friend } - @users
    #friends_array += inverse_friendships.map{|friendship| friendship.user} - @users
    #friends_array.compact
  #end
  
  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map{|friendship| friendship.friend if !friendship.confirmed}.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map{|friendship| friendship.user if !friendship.confirmed}.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
