# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image
  validates :content, presence: true, length: { maximum: 1000 }
  accepts_nested_attributes_for :comments
  accepts_nested_attributes_for :likes
end
