# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: { text: true }, length: { maximum: 100 }
end
