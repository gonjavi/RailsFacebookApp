# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validates :user, uniqueness: { scope: :friend }
 
  def confirm_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user and f.friend == self }
    friendship.confirmed = true
    friendship.save
  end
end
