# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  validates :user_id, presence: true
end
