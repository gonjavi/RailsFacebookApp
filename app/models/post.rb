# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :content, presence: { text: true }, length: { maximum: 100 }
  accepts_nested_attributes_for :comments
  accepts_nested_attributes_for :likes
end
