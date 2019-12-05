# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes, dependent: :destroy
  validates :content, presence: { string: true }
  validates :user_id, presence: true
  validates :post_id, presence: true
  accepts_nested_attributes_for :likes
end
